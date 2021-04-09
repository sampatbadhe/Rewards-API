# frozen_string_literal: true
module Api
  module V1
    # API V1 AuthenticationController
    class AuthenticationController < Api::V1::ApiController
      skip_before_action :validate_token, only: [:google_signup]

      resource_description do
        short 'Google Login Process'
        formats ['json']
      end

      def_param_group :user_auth do
        param :user_auth, Hash, required: true
        param :first_name, String, allow_nil: false, desc: 'First name of the user'
        param :last_name, String, allow_nil: false, desc: 'Family name of the user'
        param :email, String, allow_nil: false, desc: 'User email address'
        param :google_uid, String, allow_nil: false, desc: 'OAuth Google User ID'
      end

      api :POST, '/v1/auth/google_signup', 'Signup via Google'
      description <<-EOS
        The Google OAuth params recieved on the client side must be passed here.
        The API stores the information from the OAuth and creates a new record.
        In case the user was already created, the API doesnt create another user record,
        it instead sends the JWT token

        ===If successful
        * User record will be created
        * JWT token will be sent

        ===Response status codes
        * 200 - returned on successful registration
        * 422 - returned if the params are invalid
      EOS
      def google_signup
        user = User.register_user(auth_params)
        render json: { token: tokenize(user) }
      end

      private

      def auth_params
        attributes = %i[first_name last_name email google_uid]
        params.require(:user_auth).permit(attributes)
      end

      def tokenize(user)
        Token.new.generate_token(id: user.id)
      end
    end
  end
end
