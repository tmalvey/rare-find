require 'liquid'

class Listing
  include MongoMapper::Document
  safe

  key :listing_id, String, :required => true
  key :query_id, String, :required => true
  key :transaction_id, String, :required => true
  key :title, String, :required => true
  key :url, String, :required => true
  key :price, String
  key :location, String
  key :has_image, Boolean, :required => true
  key :category, String
  timestamps!

  attr_accessible :listing_id, :transaction_id, :title, :url, :price, :location, :has_image, :category
  liquid_methods :url, :title, :price, :location

  def do_safe_save
    begin
      save!
    rescue
      return false
    end
    true
  end

  def self.create_indexes
    self.ensure_index(:listing_id)
    self.ensure_index(:transaction_id)
    self.ensure_index([[:listing_id, 1], [:query_id, 1]], :unique => true)
  end
end