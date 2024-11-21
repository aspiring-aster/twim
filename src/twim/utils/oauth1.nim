import std/[strformat,random,strutils, base64]
import ../utils/xapi
import nimcrypto

proc percentEncode(s: string): string =
  const safe = {'a'..'z', 'A'..'Z', '0'..'9', '-', '.', '_', '~'}
  result = newStringOfCap(s.len * 3)
  for c in s:
    if c in safe:
      result.add(c)
    else:
      result.add('%')
      result.add(toHex(ord(c), 2))

# Random string for oauth_nonce
proc OauthNonce*(): string =
  const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  result = ""
  for _ in 0 .. 10:
    result.add(alphabet[rand(alphabet.high)])

proc OauthSignature*(xAPI: XAPI, httpMethod:string, endpoint:string, text: string, oAuthNonce: string, timeStamp: int):string =
  # Follow https://developer.x.com/en/docs/authentication/oauth-1-0a/creating-a-signature
  #
  var outputString:string =
    fmt"{httpMethod}&"&
    &"{percentEncode(endpoint)}&"

  var paramString:string =
    fmt"oauth_consumer_key={xAPI.consumerKey}&"&
    &"oauth_nonce={oAuthNonce}&"&
    &"oauth_signature_method=HMAC-SHA1&"&
    &"oauth_timestamp={timeStamp}&"&
    &"oauth_token={xAPI.accessToken}&"&
    &"oauth_version=1.0"

  paramString = percentEncode(paramString)

  var signatureBase = outputString & paramString


  signatureBase = signatureBase.replace("+", "%20")
  signatureBase = signatureBase.replace("%7E", "~")  # Don't encode ~


  var signingKey:string = fmt"{xAPI.consumerSecret}&{xAPI.tokenSecret}"

  let hmac = sha1.hmac(signingKey, signatureBase)
  result = base64.encode(hmac.data)
  result = percentEncode(result)
