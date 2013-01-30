ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address   => "smtp.mandrillapp.com",
   :port      => 587, # or 587
   :enable_starttls_auto => true, # detects and uses STARTTLS
   :user_name => "beta.test@soxialit.com",
   :password  => "Gf0eBZ_WJFWI9SpPEMlhTg",
   :authentication => 'login' # Mandrill supports 'plain' or 'login'
}
=begin
ActionMailer::Base.smtp_settings = {
     :address              => "smtp.gmail.com",
     :port                 => 587,
     :domain               => "soxialit.com",
     :user_name            => "beta.test@soxialit.com",
     :password             => "betatest",
     :authentication       => "plain",
     :enable_starttls_auto => true
}
=end  
ActionMailer::Base.default_url_options[:host] = "soxialit.com"

