import std/[httpclient]
import ../utils/[xapi, oauth1]

const MEDIA_ENDPOINT: string = "https://upload.twitter.com/1.1/media/upload.json"

proc PostMedia*(xAPI: XAPI, fileName: string): Response =
  ## POST to 1.1/media/upload.json endpoint
  ## This will the submit media that adheres to https://developer.x.com/en/docs/x-api/v1/media/upload-media/overview

  var client: HttpClient = newHttpClient()

  let authString: string = generateOauthAuthString(xapi, MEDIA_ENDPOINT, fileName)

  client.headers = newHttpHeaders({"Content-Type": "multipart/form-data",
    "authorization": authString})

  let multipart = newMultipartData()
  multipart.addFiles({"media": fileName})

  var response: Response
  try:
    response = client.request(MEDIA_ENDPOINT,
        httpMethod = HttpPost, multipart = multipart)
    result = response
  finally:
    client.close()
