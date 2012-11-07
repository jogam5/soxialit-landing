CarrierWave.configure do |config|
	
	
  config.fog_credentials = {
    provider:                'AWS',       # required
    aws_access_key_id:      'AKIAISOYROBHPU657TUA',       # required
    aws_secret_access_key: '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'       # required
  }
  config.fog_directory  = 'railscast/test'                     # required
  
end