require 'rubygems'
require 'mail'

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
  subject 'test subject'
  body 'test body text'
end

mail.deliver!