require 'rubygems'
require 'mechanize'
require 'uuidtools'
require 'mongo_mapper'
require 'resque'


class QueryProcessor

  def  initialize
    MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
    MongoMapper.database = 'rare-find'
    @transaction_id = UUIDTools::UUID.random_create
  end

  def run
    send_notification = false

    queries = Query.runnable_queries

    queries.each do |query|
      dom = get_dom(query.url)

      #puts "running query: #{query.to_xml}"

      dom.css('.row').each do |raw_listing|
        listing = ListingParser.parse(raw_listing, query.id, @transaction_id)
        #puts "found listing #{listing}"

        if listing.do_safe_save
          send_notification = true
        end
      end

      Resque.enqueue(NotificationJob, @transaction_id.to_s) if send_notification
      query.go_to_sleep
    end
  end

  def get_dom (url)
    agent = Mechanize.new
    agent.get(url).search('p.row')
  end

  def save_listing(listing)
    if listing.create
      listings_digest << listing.to_s
    end
  end

end