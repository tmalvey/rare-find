class Message
  include MongoMapper::Document

  key :recipient, String, :required => true
  key :sender, String, :required => true
  key :subject, String, :required => true
  key :body, String, :required => true

  attr_accessible :recipient, :sender, :subject, :body
end