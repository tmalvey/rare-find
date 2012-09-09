class Mailer
  def self.deliver (msg)

    Mail.defaults do
      delivery_method :smtp, { :address              => MAIL_CONFIG['address'],
                               :port                 => MAIL_CONFIG['port'],
                               :domain               => MAIL_CONFIG['domain'],
                               :user_name            => MAIL_CONFIG['user_name'],
                               :password             => MAIL_CONFIG['password'],
                               :authentication       => MAIL_CONFIG['authentication'],
                               :enable_starttls_auto => MAIL_CONFIG['enable_starttls_auto'],  }
    end


    mail = Mail.new do
      to msg.recipient
      from MAIL_CONFIG['from']
      subject msg.subject
      html_part do
        content_type 'text/html; charset=UTF-8'
        body msg.body
      end
    end

    mail.deliver!
  end
end