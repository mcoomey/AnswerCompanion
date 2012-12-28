ActionMailer::Base.smtp_settings = {
  :address => 'mail.answercompanion.com',
  :port => 587,
  :domain => 'answercompanion.com',
  :authentication => :login,
  :user_name => 'mcoomey@answercompanion.com',
  :password => 'Excel407?',
  :delivery_method => :smtp,
	:raise_delivery_errors => true,
	:perform_deliveries => true,
	:enable_starttls_auto => false,
	:default_charset => 'utf-8'
}

# depricated --> ActionMailer::Base.default_url_options[:host] = "localhost:3000"
# config.action_mailer.default_url_options = { :host => "localhost:3000" }
