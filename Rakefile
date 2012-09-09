require 'resque/tasks'
require "./config/init.rb"

task "resque:setup" do
  require "config/resque.rb"
end

desc "Run rspec tests"
task "rspec:test" do
  test_files = FileList['spec/**/*_spec.rb']
  verbose = true
end

namespace :db  do
  namespace :mongo do

    task :connection do
      DbAccess.connect
    end

    desc "Create mongo_mapper indexes"
    task :index => :connection do
      Query.create_indexes
      Listing.create_indexes
    end

  end
end