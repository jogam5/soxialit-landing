if ["production"].include?(Rails.env)
  MIXPANEL_TOKEN = "5e344db467e2f971ffccde4566fe2da4"
  YourApplication::Application.config.middleware.use "Mixpanel::Tracker::Middleware", MIXPANEL_TOKEN
else
  class DummyMixpanel
    def method_missing(m, *args, &block)
      true
    end
  end
end