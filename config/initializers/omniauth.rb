Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_APP_SECRET, FACEBOOK_APP_ID
end

