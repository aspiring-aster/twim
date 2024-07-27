import std/[httpclient, strformat, json, times, strutils]
import ../utils/[xapi, oauth1]

const TWEET_ENDPOINT*: string = "https://api.twitter.com/2/tweets"

proc PostTextTweet*(xAPI: XAPI, text: string): string =
  var client: HttpClient = newHttpClient()
  var oauthNonce: string = OauthNonce()
  var timeStamp: int = toInt(epochTime())
  var oauthSignature:string = OauthSignature(xApi, "POST", TWEET_ENDPOINT, text, oauthNonce, timeStamp)
  var AUTH_STRING: string =
    &"OAuth oauth_consumer_key=\"{xAPI.consumerKey}\"," &
    &"oauth_token=\"{xAPI.accessToken}\"," &
    &"oauth_signature_method=\"HMAC-SHA1\"," &
    &"oauth_timestamp=\"{timeStamp}\"," &
    &"oauth_nonce=\"{oauthNonce}\"," &
    &"oauth_version=\"1.0\"," &
    &"oauth_signature=\"{oauthSignature}\""

  client.headers = newHttpHeaders({"Content-Type": "application/json",
    "authorization": AUTH_STRING})
  let body = %*{
    "text": &"{text}"
  }


  var response: Response
  try:
    response = client.request(TWEET_ENDPOINT,
        httpMethod = HttpPost, body = $body)
    result = response.body
  finally:
    client.close()

proc PostTextTweet*(xAPI: XAPI, text: string, media_ids: seq[string]): string =

  var client: HttpClient = newHttpClient()
  var oauthNonce: string = OauthNonce()
  var timeStamp: int = toInt(epochTime())
  var oauthSignature:string = OauthSignature(xApi, "POST", TWEET_ENDPOINT, text, oauthNonce, timeStamp)
  var AUTH_STRING: string =
    &"OAuth oauth_consumer_key=\"{xAPI.consumerKey}\"," &
    &"oauth_token=\"{xAPI.accessToken}\"," &
    &"oauth_signature_method=\"HMAC-SHA1\"," &
    &"oauth_timestamp=\"{timeStamp}\"," &
    &"oauth_nonce=\"{oauthNonce}\"," &
    &"oauth_version=\"1.0\"," &
    &"oauth_signature=\"{oauthSignature}\""

  client.headers = newHttpHeaders({"Content-Type": "application/json",
    "authorization": AUTH_STRING})


  let body = %*{
    "text": &"{text}",
    "media": {
      "media_ids": media_ids
    }
  }

  var response: Response
  try:
    response = client.request(TWEET_ENDPOINT,
        httpMethod = HttpPost, body = $body)
    result = response.body
  finally:
    client.close()
