FactoryGirl.define do
  factory :query do
    url 'http://austin.craigslist.org/search/bar?query=fritos&catAbb=sss'
    #url 'http://austin.craigslist.org/search/sss?query=abcdefghijklmnopqrstuvwxyz&srchType=A'
    title 'No Results'
    recipient 'test@rare-find.com'
    run_after_ts Time.now.utc - 10
    run_interval_sec 60
  end
end