require "spec_helper"
require 'vcr'

describe "Query Processor Spec" do
  before(:each) do
    q = build(:query)
    q.save.should be_true
  end

  it "should find all listings" do
    VCR.use_cassette('fritos_lookup') do
      processor = QueryProcessor.new
      processor.run

      Listing.all.size.should == 2
      l1 = Listing.first
      l1.title.should == "Large Vintage Fritos Brand Collector Series Tin"
      l2 = Listing.find_by_title("ice cream truck  - $2500")
      l2.url.should == 'http://sanantonio.craigslist.org/cto/3203732122.html'
    end
  end

end