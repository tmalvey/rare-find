require 'rubygems'
require 'mail'
require 'mongo'
require 'mongo_mapper'
require 'liquid'


class NotificationJob
  @queue = :listing_notification
  @email_template = "lib/rare-find/workers/templates/email.liquid"

  def self.perform (transaction_id, query_ids)
    DbAccess.connect

    queries = Hash.new
    msg_recipient = nil

    query_ids.each do |q_id|
      query = Query.find(q_id)
      queries[query.title] = query.listings.all(:transaction_id => transaction_id)

      msg_recipient ||= query.recipient
    end

    Mailer.deliver(get_message(queries, msg_recipient))
  end


  # private
  def self.get_message(queries, recipient)
    body = get_message_body(queries)
    Message.new(:recipient => recipient, :subject => 'You have a rare find!', :body => body)
  end

  def self.get_message_body(queries)
    query_parser = Liquid::Template.parse(File.new(@email_template).read)
    query_parser.render 'queries' => queries
  end

  private_class_method :get_message
  private_class_method :get_message_body
end