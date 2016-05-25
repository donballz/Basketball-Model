require 'mail'

Mail.defaults do
  delivery_method :smtp, :address    => "smtp-relay.gmail.com",
                          :port       => 465,
                          :user_name  => 'adoubledot@gmail.com',
                          :password   => '<pswd>',
                          :enable_ssl => true
end

mail = Mail.new do
  from    'adoubledot@gmail.com'
  to      'donald.armstead@gmail.com'
  subject 'Code completed'
  body    'Now get back to work.'
end

mail.deliver