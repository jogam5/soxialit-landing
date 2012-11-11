Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "APP_ID", "APP_SECRET",
  		 	:scope => 'email, user_birthday, user_location, publish_stream, read_friendlists'
end