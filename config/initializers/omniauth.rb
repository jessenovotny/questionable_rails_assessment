Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end

#  export FACEBOOK_KEY=174114333022758
#  export FACEBOOK_SECRET=84e083474eff08ee027558e0fb57041b