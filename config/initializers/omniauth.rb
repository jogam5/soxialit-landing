Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '439343236107925', 'fb1c82f1f5893548e750e18e0b67362e',
  		 	:scope => 'email,user_birthday,read_stream, publish_stream'
  #provider :twitter, "bh0NqOQkC1Hi1M8ib37jQ", "yEZGPrpWeXzRdYeqLuxsNs2IwkW961Lc6f32HQFKU"
end