type
  XAPI* = object
    consumerKey*: string
    consumerSecret*: string
    accessToken*: string
    tokenSecret*: string
    bearerToken*: string

proc newXAPI*(consumer_key: string, consumer_secret: string,
    access_token: string, token_secret: string, bearer_token: string): XAPI =
  ## X API Client with bearer token. Use if you if you need outah2 endpoints
  ## which is most endpoints
  return XAPI(consumerKey: consumer_key, consumerSecret: consumerSecret,
accessToken: access_token, tokenSecret: token_secret, bearerToken: bearer_token)


proc newXAPI*(consumer_key: string, consumer_secret: string,
    access_token: string, token_secret: string): XAPI =
  ## X API Client without bearer token. Use if you only need ouath1 endpoints
  ## such as POST /tweet and POST /media
  return XAPI(consumerKey: consumer_key, consumerSecret: consumerSecret,
accessToken: access_token, tokenSecret: token_secret, bearerToken: "")

