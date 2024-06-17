import ../src/xnim

when isMainModule:
  const API_KEY: string = "APIKEY"
  const OAUT_TOKEN: string = "OAUT_TOKEN"

  const xCli: XAPI = newXAPI(API_KEY, OAUT_TOKEN)
  let res: string = xCli.PostTextTweet("From X.nim")
  echo res

