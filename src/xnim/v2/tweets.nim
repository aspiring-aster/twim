import std/[httpclient, strformat, json, times,random,strutils, base64]
import ../utils/xapi
import nimcrypto

const TWEET_ENDPOINT*: string = "https://api.twitter.com/2/tweets"

proc percentEncode(s: string): string =
  const safe = {'a'..'z', 'A'..'Z', '0'..'9', '-', '.', '_', '~'}
  result = newStringOfCap(s.len * 3)
  for c in s:
    if c in safe:
      result.add(c)
    else:
      result.add('%')
      result.add(toHex(ord(c), 2))

# Example usage
echo percentEncode("Hello World!") # Output: Hello%20World%21

# Random string for oauth_nonce
proc OauthNonce(): string =
  const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  result = ""
  for _ in 0 .. 10:
    result.add(alphabet[rand(alphabet.high)])
  return result

proc OauthSignature(xAPI: XAPI, text: string, oAuthNonce: string, timeStamp: int):string =
  # Follow https://developer.x.com/en/docs/authentication/oauth-1-0a/creating-a-signature
  # For now, hard code POST as HTTP method
  #

  var outputString:string =
    fmt"POST&"&
    &"{percentEncode(TWEET_ENDPOINT)}&"

  echo "outputString : " & outputString

  var paramString:string =
    fmt"oauth_consumer_key={xAPI.consumerKey}&"&
    &"oauth_nonce={oAuthNonce}&"&
    &"oauth_signature_method=HMAC-SHA1&"&
    &"oauth_timestamp={timeStamp}&"&
    &"oauth_token={xAPI.accessToken}&"&
    &"oauth_version=1.0"
    # &"status={text}"

  paramString = percentEncode(paramString)
  echo "paramString : " & paramString

  var signatureBase = outputString & paramString


  signatureBase = signatureBase.replace("+", "%20")
  signatureBase = signatureBase.replace("%7E", "~")  # Don't encode ~

  echo "SignatureBase: " & signatureBase

  var signingKey:string =
    fmt"{xAPI.consumerSecret}&{xAPI.tokenSecret}"

  let hmac = sha1.hmac(signingKey, signatureBase)
  result = base64.encode(hmac.data)
  result = percentEncode(result)

  return result

proc PostTextTweet*(xAPI: XAPI, text: string): string =
  var client: HttpClient = newHttpClient()
  var oauthNonce: string = OauthNonce()
  var timeStamp: int = toInt(epochTime())
  var oauthSignature:string = OauthSignature(xApi, text, oauthNonce, timeStamp)
  var AUTH_STRING: string =
    &"OAuth oauth_consumer_key=\"{xAPI.consumerKey}\"," &
    &"oauth_token=\"{xAPI.accessToken}\"," &
    &"oauth_signature_method=\"HMAC-SHA1\"," &
    &"oauth_timestamp=\"{timeStamp}\"," &
    &"oauth_nonce=\"{oauthNonce}\"," &
    &"oauth_version=\"1.0\"," &
    &"oauth_signature=\"{oauthSignature}\""

  echo AUTH_STRING
  client.headers = newHttpHeaders({"Content-Type": "application/json",
    "authorization": AUTH_STRING})
  let body = %*{
    "text": &"{text}"
  }

  var response: Response
  try:
    response = client.request(TWEET_ENDPOINT,
        httpMethod = HttpPost, body = $body)
  finally:
    client.close()
  return response.body
