# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# config.action_mailer.delivery_method = :smtp
# config.action_mailer.smtp_settings = {
#     address:              'smtp.gmail.com',
#     port:                 25,
#     domain:               'example.com',
#     user_name:            '<username>',
#     password:             '<password>',
#     authentication:       'plain',
#     enable_starttls_auto: true  
#  }

config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {   
    :openssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,      
    :ssl => true,
    :enable_starttls_auto => true,  #this is the important stuff!
    :address        => 'smtp.xxxx.xxx',
    :port           => 25,
    :domain         => 'xxxxxx',
    :authentication => :plain,
    :user_name      => '',
    :password       => 'xxxxxxxxx'
  }
