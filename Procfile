mongodb:    mongod run --config /usr/local/etc/mongod.conf
redis:      redis-server /usr/local/etc/redis.conf
resque:     env VVERBOSE=1 QUEUE='listing_notification' TERM_CHILD=1 bundle exec rake resque:work