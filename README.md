# Amazon Wishlist to Trello

## Utility

Syncs an Amazon Wishlist with trello

## Usage

Every time you run the rake, it checks the amazon wishlist (just the first page, pagination is not implemented yet, no need for my use) and create a trello card via trello-to-email in the selected board. It also have an anti-duplication service.

The good things is that you can run the service frequently for free in Heroku.

**Warning: Email-To-Trello can take up to 15 minutes to delay, keep calm

## Dependences and Environment variables

The system depends on two external apps:

- [Amazon Wishlist](http://www.amazon.com)
- [Trello](http://www.trello.com)

And the [emailing system](http://www.postmarkapp.com) and the database (redis).

The environment variables that you have to provide are:

- WISHLIST_URL: Wishlist URL to sync

**https://www.amazon.es/gp/registry/wishlist/3YY2Z999ZZZZ1P is the structure of one of my lists. Remeber to set the list to public one

- TRELLO_EMAIL: Email of [email-to-trello](http://blog.trello.com/create-cards-via-email/)

**it looks like:  mrandomuser+113323124dadas131rui@boards.trello.com**

- TRELLO_LABEL: It will be added at the end of the card title if you put for example '#Books' the card will have the label '#Books', if you put the label '#Books #to_read' it will have both labels and so on.

- POSTMARK_API_KEY: Is the API key of [Postmark](http://www.postmarkapp.com) (first 25.000 emails for free)

**it looks like: 13312ss8e-1a37-3192-9991-ss3222z8z99c**

- FROM_EMAIL: A valid postmark from email, take a look in Postmark.

- REDIS_URL: For the Redis config. Provided by Heroku

## Development

Setup:

```
git@github.com:MiguelBel/AmazonWishlistToTrello.git
cd AmazonWishlistToTrello/
mix deps.get
```

You can execute the task with:

`WISHLIST_URL=your_wl_url TRELLO_EMAIL=your_trello_email TRELLO_LABEL=your_trello_label POSTMARK_API_KEY=your_postmark_ak FROM_EMAIL=your_from_email mix run synchronize.ex`

### Deploy

Heroku is the easiest way of host the service for free.

```
heroku create
heroku buildpacks:set https://github.com/HashNuke/heroku-buildpack-elixir # Allows to execute Elixir in heroku
git push heroku master
heroku config:set WISHLIST_URL=your_wl_url TRELLO_EMAIL=your_trello_email TRELLO_LABEL=your_trello_label POSTMARK_API_KEY=your_postmark_ak FROM_EMAIL=your_from_email
heroku addons:create heroku-redis:hobby-dev # Adds the heroku addon, it is already configured
heroku addons:create scheduler:standard # Adds the scheduler
heroku addons:open scheduler
```

nd then it will open a webpage where you have to set the job and the frequency. You call to the job with the command `mix run synchronize.ex`

The final result should look like:

![GH](https://cloud.githubusercontent.com/assets/1566116/12868452/a4e8ca3c-cd07-11e5-9c77-4c4603e2bf4b.png)
