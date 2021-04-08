module Api
  module V1
    class ApiController < ApplicationController
      include ParamReader

      resource_description do
        api_version 'v2'
      end

      skip_before_action :validate_token, only: [:error]
    end
  end
end
