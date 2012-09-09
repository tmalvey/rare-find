FactoryGirl.define do
  factory :query do
    url 'http://austin.craigslist.org/search/bar?query=fritos&catAbb=sss'
    title 'Fritos'
    recipient 'test@rare-find.com'
    run_after_ts Time.now.utc
    run_interval_sec 60
  end
end