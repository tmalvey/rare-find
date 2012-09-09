require 'rubygems'

class QueryProcessor

  def initialize
    DbAccess.connect
    @transaction_id = UUIDTools::UUID.random_create
    @send_notification = false
    @query_ids = Set.new
  end

  def run
    queries = Query.active_queries

    queries.each do |query|
      process_query(query)
    end

    Resque.enqueue(NotificationJob, @transaction_id.to_s, @query_ids) if @send_notification
  end


  private

  def process_query(query)
    dom = get_dom(query.url)

    dom.css('.row').each do |raw_listing|
      process_listing(query.id, raw_listing)
    end

    query.go_to_sleep
  end

  def process_listing(query_id, raw_listing)
    listing = ListingParser.parse(raw_listing, query_id, @transaction_id)

    if listing.save
      @query_ids.add(query_id)
      @send_notification = true
    end
  end

  def get_dom (url)
    agent = Mechanize.new
    agent.get(url).search('p.row')
  end
end