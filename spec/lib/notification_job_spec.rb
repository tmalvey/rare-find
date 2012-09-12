require "spec_helper"
require 'resque_spec'

describe "The Notification Job" do

  before(:each) do
    ResqueSpec.reset!

    @default_query = build(:query)
    @default_query.save.should be_true

    VCR.use_cassette('fritos_lookup') do
      processor = QueryProcessor.new
      @transaction_id = processor.run
    end
  end

  it "should process a transaction id" do
    NotificationJob.perform(@transaction_id)
  end
end