require "spec_helper"

describe Query do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:recipient) }
  it { should validate_presence_of(:run_after_ts) }
  it { should validate_presence_of(:run_interval_sec) }

  it "should save when valid" do
    q = build(:query).save.should be_true
  end

  it "should validate uniqueness of url" do
    create(:query).should be_true
    q2 = build(:query)
    q2.save.should be_false
    q2.errors['url'].first.should == "has already been taken"
  end

  it "should validate url format" do
    build(:query, url: "a ding dang dong").save.should be_false
  end

  it "should validate date properties of run_after_ts" do
    begin
      q = build(:query, run_after_ts: 'a string')
    rescue ArgumentError, NameError => err
       err.to_s.should == 'no time information in "a string"'
    end
  end

  it "should validate run_after timestamp updated when query goes to sleep" do
    q = build(:query)
    ts = q.run_after_ts
    q.save.should be_true
    q.go_to_sleep
    q.run_after_ts.should > ts
  end
end