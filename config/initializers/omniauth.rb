OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '286795618485948','ba02f0735cfdd4126f2ab68c0c00288d', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
