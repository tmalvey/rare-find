require "spec_helper"
require 'resque_spec'
require 'vcr'


describe "The Query Processor" do

  before(:each) do
    ResqueSpec.reset!

    @default_query = build(:query)
    @default_query.save.should be_true
  end

  it "should process all active queries" do
    VCR.use_cassette('fritos_lookup') do
      processor = QueryProcessor.new
      processor.run

      # check for updated timestamp on queries
      q = Query.find(@default_query.id)
      q.run_after_ts.should > @default_query.run_after_ts
    end
  end

  it "should not process inactive queries" do
    query = Query.find(@default_query.id)
    query.run_after_ts = Time.now.utc + 10
    query.save

    VCR.use_cassette('fritos_lookup') do
      processor = QueryProcessor.new
      processor.run

      # check for updated timestamp on queries
      q = Query.find(query.id)
      q.run_after_ts.to_i.should == query.run_after_ts.to_i
    end
  end

  it "should not send a notification when there are no listings found" do
    VCR.use_cassette('no_results_lookup') do
      processor = QueryProcessor.new
      processor.run
      NotificationJob.should have_queue_size_of(0)
    end
  end

  it "should save the associated listings" do
    VCR.use_cassette('fritos_lookup') do
      processor = QueryProcessor.new
      processor.run

      q = Query.find(@default_query.id)
      listings = q.listings
      listings.size.should == 2

      listing_1 = listings.first
      listing_1.title.should == "Large Vintage Fritos Brand Collector Series Tin"

      listing_2 = listings.find_by_title("ice cream truck  - $2500")
      listing_2.url.should == 'http://sanantonio.craigslist.org/cto/3203732122.html'
    end
  end

  it "should enqueue a transaction for each query" do
    VCR.use_cassette('fritos_lookup') do
      processor = QueryProcessor.new
      transaction_id = processor.run
      NotificationJob.should have_queue_size_of(1)

      # hmm. resque_spec having a problem with UUIDs
      #queued_job = Resque.peek("listing_notification", start=0, count=1)[0]
      #queued_job["args"][0].should == transaction_id
    end
  end

end