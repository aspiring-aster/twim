import ../src/xnim

when isMainModule:
  const API_KEY: string = "PUT API KEY HERE"
  const OAUT_TOKEN: string = "PUT ACCESS TOKEN HERE "

  const xCli: XAPI = newXAPI(API_KEY, OAUT_TOKEN)
  PostTextTweet(xCli, "post this")
