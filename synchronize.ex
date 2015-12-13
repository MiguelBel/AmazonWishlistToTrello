url = System.get_env("REDIS_URL") || "redis://127.0.0.1:6379"
redis = Exredis.start_using_connection_string(url)
System.get_env("WISHLIST_URL")
|> AmazonWishlist.get_items
|> EmailToTrello.sync_list(redis)