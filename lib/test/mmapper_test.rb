require 'rubygems'
require 'mongo_mapper'
require '../../lib/rare-find/model/query'
require '../../lib/rare-find/model/listing'
require 'liquid'

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "rare-find"

q = Query.new
#q.url = "http://austin.craigslist.org/search/sss?query=tomato+cage"
q.url = "http://austin.craigslist.org/search/sss?query=colander+rubbermaid"
q.recipient = "tmalvey@gmail.com"
q.run_after_ts = Time.now.utc + 15
q.run_interval_sec = 5
q.save!

#l = Listing.new
#l.listing_id = '1'
#l.transaction_id = 'asdf'
#l.save



#test = @template.render('name' => 'tobi')
#puts test
#@template = Liquid::Template.parse("hi {{name}}")
#test = @template.render('name' => 'tobi')

#{% for page in pages %}
#        {{page.page_name}}<br/>
#    {% endfor %}

file_path = "./email.liquid"
temp = Liquid::Template.parse(File.new(file_path).read)
puts temp.render 'queries' => Query.runnable_queries.to_a
#puts test
#puts qs
#
#queries.each do |q|
#  puts q.url
#  puts q.recipient
#end

