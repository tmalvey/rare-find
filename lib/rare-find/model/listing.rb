class Listing
  include MongoMapper::Document
  include URLFormatter
  belongs_to :query
  safe

  key :listing_id, String, :required => true, :length => 1..200
  key :query_id,  ObjectId, :required => true, :length => 1..200
  key :transaction_id, String, :required => true, :length => 1..200
  key :title, String, :required => true, :length => 1..200
  key :url, String, :required => true, :length => 1..200
  key :price, String, :length => 0..200
  key :location, String, :length => 0..200
  key :has_image, Boolean, :required => true
  key :category, String, :length => 0..200
  timestamps!

  before_save :format_url
  validates_uniqueness_of :listing_id, :scope => :query_id
  validates_format_of :url, :with => URI::regexp(%w(http https))

  attr_accessible :listing_id, :transaction_id, :title, :url, :price, :location, :has_image, :category
  liquid_methods :url, :title, :price, :location

  def self.create_indexes
    self.ensure_index(:listing_id)
    self.ensure_index(:transaction_id)
    self.ensure_index([[:listing_id, 1], [:query_id, 1]], :unique => true)
  end
end