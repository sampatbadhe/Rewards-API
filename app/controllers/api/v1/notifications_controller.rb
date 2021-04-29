# frozen_string_literal: true
module Api
  module V1
    # API V1 NotificationsController
    class NotificationsController < Api::V1::ApiController

      def index
        render json: current_user.notifications, status: :ok
      end
    end
  end
end
