type
  XAPI* = object
    consumerKey*: string
    oauthToken*: string

proc newXAPI*(consumer_key: string, oauth_token: string): XAPI =
  return XAPI(consumerKey: consumer_key, oauthToken: oauth_token)

