import std/[httpclient, strformat, json]
import ../utils/xapi

const TWEET_ENDPOINT*: string = "https://api.twitter.com/2/tweets"

proc PostTextTweet*(xAPI: XAPI, text: string): void =
  let client: HttpClient = newHttpClient()
  let AUTH_STRING: string =
    fmt"OAuth oauth_consumer_key={xAPI.consumerKey}," &
    fmt"oauth_token={xAPI.oauthToken}," &
    &"oauth_signature_method=\"HMAC-SHA1\"," &
    &"oauth_timestamp=\"1718564600\"," &
    &"oauth_nonce=\"NW8GQcTk2MP\"," &
    &"oauth_version=\"1.0\"," &
    &"oauth_signature=\"WGzidzAKFBDufoQUYcJ9G%2BCpTus%3D\""


  client.headers = newHttpHeaders({"Content-Type": "application/json",
    "authorization": AUTH_STRING})
  let body = %*{
    "text": &"{text}"
  }
  let response = client.request(TWEET_ENDPOINT, httpMethod = HttpPost, body = $body)

