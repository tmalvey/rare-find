require 'resque/tasks'
require 'mongo'
require 'mongo_mapper'
RF_ROOT = "#{File.dirname(__FILE__)}"
require "#{RF_ROOT}/config/load_config.rb"


task "resque:setup" do
  require "#{RF_ROOT}/config/resque.rb"
end

namespace :db  do
  namespace :mongo do

    task :connection do
      MongoMapper.connection = Mongo::Connection.new(DB_CONFIG['host'], DB_CONFIG['port'])
      MongoMapper.database = DB_CONFIG['database']
    end

    desc "Create mongo_mapper indexes"
    task :index => :connection do
      Listing.create_indexes
    end

  end
end