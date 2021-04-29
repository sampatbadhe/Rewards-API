module Api
  module V1
    class ApiController < ApplicationController
      include ParamReader
      include ActionController::Helpers
      include TokenValidatable

      resource_description do
        api_version 'v1'
      end

      skip_before_action :validate_token, only: [:error]
      skip_before_action :verify_authenticity_token

      # --------------
      # Rescue Errors
      # --------------

      rescue_from ActiveRecord::RecordInvalid, with: :invalid_params
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ApiErrors::BaseError, with: :render_api_error

      # -------------
      # Helpers
      # -------------

      helper_method :current_user
      before_action :current_user

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

      # Read token data from request Authorization header
      # Parse the user_id
      # Assign the current_user
      def current_user
        @current_user ||= read_from_token
      end

      def read_from_token
        return nil unless token.valid? && token_data.present?

        user_id = token.read('user_id')
        user = User.find_by(id: user_id)
        return nil if user.nil?

        user
      end

      def token_data
        token.data && token.data[0]['user_id']
      end
    end
  end
end
