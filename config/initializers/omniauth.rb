OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,'app_id','secret',scope: 'public_profile,email',info_fields: 'id,first_name,middle_name,last_name,email,link'
end
