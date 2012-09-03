

# THE QUERY DATABASE (url, expiration_ts, recipient)
# poll for expired queries
#

# QUERY FOR NEW LISTINGS
# find listings
# if found create transaction_id
# for each listing found
#   attempt store (query_id, listing id, digest)
# at least one listing store attempt successful
## send transaction_id to queue

# NOTIFICATION QUEUE
#Notification worker pulls transaction (email_text, subject, recipient(s)) off the queue
# grab result string
# send notification

# clean up


# QUERY QUEUE (future upgrade with multi-threading)
# worker processes incoming queries sequentially?