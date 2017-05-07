OmniAuth.config.logger = Rails.logger
OmniAuth.config.full_host = Rails.env.production? ? 'https://domain.com' : 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV.fetch("GOOGLE_CLIENT_ID"), ENV.fetch("GOOGLE_CLIENT_SECRET"), {:provider_ignores_state => true}
end