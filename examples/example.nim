import ../src/twim

when isMainModule:

  # This is API Key
  const CONSUMER_KEY: string = "CONSUMERKEY"

  # This is the API secret key
  const CONSUMER_SECRET: string = "CONSUMERSECRET"

  # This is the Authentication Access Token
  const ACCESS_TOKEN: string = "ACCESSTOKEN"

  # This is the Authentication Access Secret
  const TOKEN_SECRET: string = "TOKENSECRET"

  const xCli: XAPI = newXAPI(CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, TOKEN_SECRET)
  let res: string = xCli.PostTextTweet("Hello from twim!")
  echo res
