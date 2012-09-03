require 'rubygems'
require 'liquid'

class Query

  include MongoMapper::Document

  key :url, String, :required => true
  key :recipient, String, :required => true
  key :run_after_ts, Time, :required => true
  key :run_interval_sec, Integer, :required => true
  timestamps!

  scope :runnable_queries, :run_after_ts.lt => Time.now.utc

  def go_to_sleep
    self.run_after_ts = Time.now.utc + run_interval_sec
    self.save!
  end

end