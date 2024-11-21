import std/[httpclient, strformat, json]
import ../utils/[xapi, oauth1]

const TWEET_ENDPOINT*: string = "https://api.twitter.com/2/tweets"

proc PostTextTweet*(xAPI: XAPI, text: string): string =
  var client: HttpClient = newHttpClient()
  let authString: string = generateOauthAuthString(xapi, TWEET_ENDPOINT, text)

  client.headers = newHttpHeaders({"Content-Type": "application/json",
    "authorization": authString})
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
  let authString: string = generateOauthAuthString(xapi, TWEET_ENDPOINT, text)

  client.headers = newHttpHeaders({"Content-Type": "application/json",
    "authorization": authString})


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
