Apipie.configure do |config|
  config.app_name = 'Rewards API'
  config.copyright = '&copy; Kiprosh'
  config.api_base_url = '/api'
  config.doc_base_url = '/api/docs'
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.default_version = 'v1'
  config.swagger_content_type_input = :json

  config.app_info = <<-EOS
    == Getting Started
  EOS
end
