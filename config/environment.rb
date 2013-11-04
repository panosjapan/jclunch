# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Money.default_currency = Money::Currency.new("GBP")
LunchOrder::Application.initialize!

ActionMailer::Base.smtp_settings = {
    :port =>           '587',
    :address =>        'smtp.mandrillapp.com',
    :user_name =>      ENV['MANDRILL_USERNAME'],
    :password =>       ENV['MANDRILL_APIKEY'],
    :domain =>         'japancentre.com',
    :authentication => :plain
}
ActionMailer::Base.delivery_method = :smtp