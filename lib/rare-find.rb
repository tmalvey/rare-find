require 'rubygems'
require 'yaml'

require 'rare-find/query_processor'
require 'rare-find/model/listing'
require 'rare-find/model/query'
require 'rare-find/listing_parser'
require 'rare-find/workers/notification_job'

RF_ROOT = File.expand_path(File.dirname(__FILE__)).gsub(/\/lib/, '')
require RF_ROOT + '/config/load_config.rb'

# respec tests +  vcr
# front end - sinatra

qp = QueryProcessor.new
qp.run