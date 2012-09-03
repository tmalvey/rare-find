require 'rubygems'
require 'mail'
require 'mongo'
require 'mongo_mapper'
require 'liquid'


class NotificationJob
  @queue = :test_q

  def self.perform (transaction_id)
    MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
    MongoMapper.database = 'rare-find'

    file_path = "lib/rare-find/workers/templates/email.liquid"
    temp = Liquid::Template.parse(File.new(file_path).read)
    listings = Listing.all(:transaction_id => transaction_id).to_a

    message = temp.render 'listings' => listings

    Mail.defaults do
      delivery_method :smtp, { :address              => "smtp.gmail.com",
                               :port                 => 587,
                               :domain               => 'localhost',
                               :user_name            => 'tmalvey@tmalvey.com',
                               :password             => '@455s82Tcfu#',
                               :authentication       => 'plain',
                               :enable_starttls_auto => true  }
    end


    mail = Mail.new do
      to 'tmalvey@gmail.com'
      from 'tmalvey@tmalvey.com'
      subject 'rare-find listings'
      html_part do
        content_type 'text/html; charset=UTF-8'
        body message
      end
    end

    mail.deliver!

  end
end