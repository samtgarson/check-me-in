# CheckMeIn
> Check yourself into Swarm automagically when you use your Mondo card

CheckMeIn is a basic RoR app which connects your Foursquare and Mondo accounts to check you into Swarm whenever you make a payment with your Mondo card.

## Contribute

- **Database**
    - This app uses _postgres_. Homebrew is the suggested installation method on a Mac.

- **Environment**
    - This app uses _.env_ to load up environment variables in development. Run `cp .env.test .env`
    - `bundle install`
    - `bundle exec rake db:setup`

- See [this stellar guide](https://github.com/middleman/middleman-heroku/blob/master/CONTRIBUTING.md) for the best ways to contribute.

---

Copyright (c) 2016 Sam Garson. See `licence.md` for details.
