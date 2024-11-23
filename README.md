# twim

A X(Formally known as Twitter) API wrapper library for Nim. Inspired by [Tweepy](https://www.tweepy.org/) and [twitter.nim](https://github.com/snus-kin/twitter.nim).

Be aware I only have free-tier API access to the X API so I will only develop for those endpoints.

This uses OAuth 1.0a.

## Endpoints supported:

- POST v2/tweets
- POST media/upload

## Install

```Bash
nimble install twim
```

## Example

```Nim
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

