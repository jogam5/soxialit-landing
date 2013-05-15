CarrierWave.configure do |config|
	config.fog_credentials = {
	   :provider =>                'AWS',       
	   :aws_access_key_id =>      ENV['S3_KEY'],       
	   :aws_secret_access_key => ENV['S3_SECRET']       
	}
  #if Rails.env.development?
	#config.fog_directory  = 'railscast'
  #else
	config.fog_directory  = 'soxialit/uploads'
  #end
end