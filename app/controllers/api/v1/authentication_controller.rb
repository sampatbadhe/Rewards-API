# frozen_string_literal: true
module Api
  module V1
    class AuthenticationController < Api::V1::ApiController
      skip_before_action :validate_token, only: [:google_signup]

      def google_signup
        user = User.new(user_params)

        if user.save
          render json: { token: tokenize(user) }
        end

        render_error(user.errors.full_messages.join('. '))
      end

      private

      def user_params
        {
          google_uid: params['user_info']['uid'],
          first_name: params['user_info']['first_name'],
          last_name: params['user_info']['last_name'],
          email: params['user_info']['email']
        }
      end

      def tokenize(user)
        Token.new.generate_token(id: user.id)
      end
    end
  end
end
