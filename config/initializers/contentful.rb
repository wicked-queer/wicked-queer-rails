ContentfulRails.configure do |config|
  config.authenticate_webhooks = true # false here would allow the webhooks to process without basic auth
  config.access_token = ENV['CONTENTFUL_DELIVERY_API_KEY']
  config.default_locale = 'en-US'
  config.preview_access_token = ENV['CONTENTFUL_PREVIEW_API_KEY']
  config.space = ENV['CONTENTFUL_SPACE_ID']
end

unless Rails.env.production?
  ContentfulModel.use_preview_api = true
end
