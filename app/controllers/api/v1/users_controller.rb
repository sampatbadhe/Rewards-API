# frozen_string_literal: true
module Api
  module V1
    # API V1 UsersController
    class UsersController < Api::V1::ApiController

      def show
        render json: current_user, status: :ok
      end
    end
  end
end
