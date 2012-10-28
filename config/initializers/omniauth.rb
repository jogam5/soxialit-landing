Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '235628993153454', '6dc90b8b268f2643ebd5b074a88db7c8',
  		 	:scope => 'email,user_birthday,read_stream, publish_stream'
  #provider :twitter, "bh0NqOQkC1Hi1M8ib37jQ", "yEZGPrpWeXzRdYeqLuxsNs2IwkW961Lc6f32HQFKU"
end