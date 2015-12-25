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
