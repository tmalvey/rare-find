require 'rubygems'

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rare-find/query_processor'
require 'rare-find/model/listing'
require 'rare-find/model/query'
require 'rare-find/listing_parser'
require 'rare-find/workers/notification_job'


qp = QueryProcessor.new
qp.run