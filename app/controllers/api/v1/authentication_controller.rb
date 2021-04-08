module Api
  module V1
    class AuthenticationController < Api::V1::ApiController
      skip_before_action :validate_token, only: [:signup]

      def google_signup
        user = User.create(user_params)

        render json: { token: tokenize(user) }
      end


      private

      def user_params
        {
          google_uid: params['user_info']['uid'],
          first_name: params['user_info']['info']['first_name'],
          last_name: params['user_info']['info']['last_name'],
          email: params['user_info']['email']
        }
      end

      def tokenize(user)
        Token.new.generate(id: user.id)
      end
    end
  end
end
