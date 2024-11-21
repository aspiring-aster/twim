import std/[httpclient]
import ../utils/[xapi, oauth1]

const MEDIA_ENDPOINT*: string = "https://upload.twitter.com/1.1/media/upload.json"

proc PostMedia*(xAPI: XAPI, fileName: string): string =

  var client: HttpClient = newHttpClient()

  let authString: string = generateOauthAuthString(xapi, MEDIA_ENDPOINT, fileName)

  client.headers = newHttpHeaders({"Content-Type": "multipart/form-data",
    "authorization": authString})

  var multipart = newMultipartData()
  multipart.addFiles({"media": fileName})


  var response: Response
  try:
    response = client.request(MEDIA_ENDPOINT,
        httpMethod = HttpPost, multipart = multipart)
    result = response.body
  finally:
    client.close()
