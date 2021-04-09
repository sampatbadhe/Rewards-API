module Api
  module V1
    class ApiController < ApplicationController
      include ParamReader

      resource_description do
        api_version 'v2'
      end

      skip_before_action :validate_token, only: [:error]

      # --------------
      # Rescue Errors
      # --------------

      rescue_from ActiveRecord::RecordInvalid, with: :invalid_params
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ApiErrors::BaseError, with: :render_api_error

      # -------------
      # Helpers
      # -------------

      def render_error(message, code: :unprocessable_entity)
        render_api_error ApiErrors::BaseError.new(message, status: code)
      end

      private

      def not_found(error)
        render_api_error ApiErrors::NotFoundError.with_text(error&.message)
      end

      def invalid_params(error)
        render_api_error ApiErrors::InvalidParamsError.with_text(error&.message)
      end

      def render_api_error(error)
        render json: error.as_json, status: error.status
      end
    end
  end
end
