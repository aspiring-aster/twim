import std/[httpclient, strformat, json, times, mimetypes]
import ../utils/[xapi, oauth1]

const MEDIA_ENDPOINT*: string = "https://upload.twitter.com/1.1/media/upload.json"

proc PostMedia*(xAPI: XAPI, fileName: string): string =

  var client: HttpClient = newHttpClient()
  var oauthNonce: string = OauthNonce()
  var timeStamp: int = toInt(epochTime())
  var oauthSignature:string = OauthSignature(xApi, "POST", MEDIA_ENDPOINT, fileName, oauthNonce, timeStamp)
  var AUTH_STRING: string =
    &"OAuth oauth_consumer_key=\"{xAPI.consumerKey}\"," &
    &"oauth_token=\"{xAPI.accessToken}\"," &
    &"oauth_signature_method=\"HMAC-SHA1\"," &
    &"oauth_timestamp=\"{timeStamp}\"," &
    &"oauth_nonce=\"{oauthNonce}\"," &
    &"oauth_version=\"1.0\"," &
    &"oauth_signature=\"{oauthSignature}\""


  client.headers = newHttpHeaders({"Content-Type": "multipart/form-data",
    "authorization": AUTH_STRING})

  var multipart = newMultipartData()
  multipart.addFiles({"media": fileName})


  var response: Response
  try:
    response = client.request(MEDIA_ENDPOINT,
        httpMethod = HttpPost, multipart=multipart)
    result = response.body
  finally:
    client.close()
