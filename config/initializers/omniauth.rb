Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 174114333022758, ENV['FACEBOOK_SECRET']
end
