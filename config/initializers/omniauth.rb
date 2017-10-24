OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['app_id'], ENV['secret'],scope: 'email',info_fields: 'id,first_name,email'
end
