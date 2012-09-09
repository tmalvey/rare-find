class DbAccess
  def self.connect
    MongoMapper.connection = Mongo::Connection.new(DB_CONFIG['host'], DB_CONFIG['port'])
    MongoMapper.database = DB_CONFIG['database']
  end
end