Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '235628993153454', '6dc90b8b268f2643ebd5b074a88db7c8',
  		 	:scope => 'email, user_birthday, user_location, publish_stream, read_friendlists'
end