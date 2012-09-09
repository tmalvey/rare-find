class Query
  include MongoMapper::Document
  include URLFormatter
  many :listings
  safe

  key :url, String, :required => true, :unique => true, :length => 1..200
  key :title, String, :required => true, :length => 1..100
  key :recipient, String, :required => true, :length => 1..100
  key :run_after_ts, Time, :required => true
  key :run_interval_sec, Integer, :required => true
  timestamps!

  before_save :format_url

  validates_numericality_of :run_interval_sec, :only_integer => true, :greater_than => 1
  validates_format_of :url, :with => URI::regexp(%w(http https))

  scope :active_queries, :run_after_ts.lt => Time.now.utc

  def go_to_sleep
    self.run_after_ts = Time.now.utc + run_interval_sec
    self.save!
  end

  def self.create_indexes
    self.ensure_index(:url, :unique => true)
  end

end