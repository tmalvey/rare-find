require 'resque/tasks'
require 'mongo'
require 'mongo_mapper'
require 'lib/rare-find/model/listing'



task "resque:setup" do
  root_path = "#{File.dirname(__FILE__)}"
  #$:<< "#{root_path}/lib"
  #$:<< "#{root_path}/lib/rare-find/model"
  #puts $LOAD_PATH

  require "#{root_path}/lib/rare-find/workers/notification_job.rb"
  require "#{root_path}/lib/rare-find/model/listing.rb"
end


namespace :db  do
  namespace :mongo do

    task :connection do
      MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
      MongoMapper.database = 'rare-find'
    end

    desc "Create mongo_mapper indexes"
    task :index => :connection do
      Listing.create_indexes
    end

  end
end