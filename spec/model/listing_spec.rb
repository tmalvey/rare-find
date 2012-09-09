require 'spec_helper'

describe Listing do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:listing_id) }
  it { should validate_presence_of(:query_id) }
  it { should validate_presence_of(:transaction_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }

  it "should save when valid" do
    l = build(:listing)
    l.save.should be_true
  end

  it "should validate url format" do
    l = build(:listing, url: 'a one and a two')
    l.save.should be_false
  end

  it "should validate url/query_id uniqueness" do
    create(:listing).should be_true
    l = build(:listing)
    l.save.should be_false
    l.errors['listing_id'] == 'has already been taken'
  end
end