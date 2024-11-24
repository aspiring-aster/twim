import std/[httpclient, strformat, json]
import ../utils/[xapi, oauth1]

const TWEET_ENDPOINT: string = "https://api.twitter.com/2/tweets"

proc PostTextTweet*(xAPI: XAPI, text: string): Response =
  ## Post a text tweet

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
    result = response
  finally:
    client.close()

proc PostTextTweet*(xAPI: XAPI, text: string, media_ids: seq[
    string]): Response =
  ## Post a text tweet with media. media_ids is a sequence of media_ids that can
  ## be obtained with the `PostMedia` method

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
    result = response
  finally:
    client.close()

# TODO: Complete this, 80% done
proc GetTweet*(xAPI: XAPI, tweet_id: string, ): Response =
  ## Get a single tweet
  if(xAPI.bearerToken is ""):
    raise newException(ValueError, "GET /tweets is a ouath 2.0 endpoint. Your X API client doesn't have a bearer token. Please get one")

  var client: HttpClient = newHttpClient()
  let endpoint = TWEET_ENDPOINT & "/" & tweet_id

  let authString: string = "Bearer " & xAPI.bearerToken

  client.headers = newHttpHeaders({"Content-Type": "application/json",
    "Authorization": authString})

  var response: Response
  try:
    response = client.request(endpoint,
        httpMethod = HttpGet)
    result = response
  finally:
    client.close()
