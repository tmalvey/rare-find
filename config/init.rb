ENV["RF_ENV"] ||= 'development'
RF_ENV = ENV["RF_ENV"]
RF_ROOT = File.expand_path(File.dirname(__FILE__)).gsub(/rare-find\/(spec|lib|config).*$/, 'rare-find/')
$LOAD_PATH.push RF_ROOT
$LOAD_PATH.push "#{RF_ROOT}/lib/rare-find/"
require 'rubygems'
require 'yaml'
require 'mechanize'
require 'uuidtools'
require 'mongo'
require 'mongo_mapper'
require 'resque'
require 'uri'
require 'liquid'
require "config/load_config"
require 'query_processor'
require 'helpers/url_formatter'
require 'model/listing'
require 'model/query'
require 'listing_parser'
require 'workers/notification_job'
require "db_access"

