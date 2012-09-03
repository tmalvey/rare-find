require 'rubygems'
require 'mechanize'
require 'mongo'


@conn = Mongo::Connection.new
@db   = @conn['cscrape']
@listings = @db['listings']

#@coll.remove
#3.times do |i|
#  @coll.insert({'a' => i+1})
#end

#puts "There are #{@coll.count} records. Here they are:"
@listings.find.each { |doc| puts doc.inspect }
