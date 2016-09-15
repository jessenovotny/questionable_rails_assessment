Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end