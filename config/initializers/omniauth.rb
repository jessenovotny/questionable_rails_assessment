Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_SECRET'], ENV['FACEBOOK_APP_ID']
end

