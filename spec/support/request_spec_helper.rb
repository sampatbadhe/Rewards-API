module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def login(current_user)
    allow_any_instance_of(::Api::V1::ApiController).to receive(:validate_token).and_return(true)
    allow_any_instance_of(::Api::V1::ApiController).to receive(:current_user).and_return(current_user)
  end
end
