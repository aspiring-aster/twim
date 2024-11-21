# twim
A X(Formally known as Twitter) API wrapper library for Nim. Inspired by [Tweepy](https://www.tweepy.org/) and [twitter.nim](https://github.com/snus-kin/twitter.nim).

Be aware I only free-tier API access to the X API so I will only develop for those endpoints.

This uses OAuth 1.0a.

## Endpoints supported:
- POST v2/tweets
- POST media/upload

## Install
```Bash
git clone https://github.com/aspiring-aster/x.nim.git
cd x.nim
nimble install
```

## Example
```Nim
import twim

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
  let res: string = xCli.PostTextTweet("Hello from X.nim!")
  echo res
```
Look at the [OMORI upscale bot](https://github.com/aspiring-aster/omori-upscale-bot-v2/tree/main) as an example for how to use this API to deploy a bot on Twitter.

## Dependencies 
- [nimcrypto](https://github.com/cheatfate/nimcrypto) - For SHA1-HMAC encoding to encode signature

## RoadMap:
- [ ] Add support for /tweets endpoints
- [ ] Add support for quote tweets
- [ ] Add suport for liking_users
- [ ] Add support for liked_tweets
- [ ] Add support for mentions
- [ ] Add get for users
- [ ] Support for /spaces endpoint
- [ ] And a bunch of other stuff listed [here](https://developer.x.com/en/portal/products/free)
