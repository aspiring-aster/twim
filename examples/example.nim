import twim

when isMainModule:

  # This is API Key
  const CONSUMER_KEY = "CONSUMERKEY"

  # This is the API secret key
  const CONSUMER_SECRET = "CONSUMERSECRET"

  # This is the Authentication Access Token
  const ACCESS_TOKEN = "ACCESSTOKEN"

  # This is the Authentication Access Secret
  const TOKEN_SECRET = "TOKENSECRET"

  const xCli = newXAPI(CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, TOKEN_SECRET)
  let res = xCli.PostTextTweet("Hello from twim!")
  echo res
