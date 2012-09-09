FactoryGirl.define do
  factory :listing do
    listing_id '3257052655'
    query_id 'ObjectId("50488439b4fc37197344d466")'
    transaction_id UUIDTools::UUID.random_create
    title 'Something Old'
    url 'http://austin.craigslist.org/zip/3257052655.html'
    price '$30'
    location 'Austin, TX'
    has_image true
    category 'farm & garden - by owner'
  end
end