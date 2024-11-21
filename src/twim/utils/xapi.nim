type
  XAPI* = object
    consumerKey*: string
    consumerSecret*: string
    accessToken*: string
    tokenSecret*: string

proc newXAPI*(consumer_key: string, consumer_secret: string, access_token: string, token_secret: string): XAPI =
  return XAPI(consumerKey: consumer_key, consumerSecret: consumerSecret, accessToken: access_token, tokenSecret: token_secret)

