# frozen_string_literal: true
module Api
  module V1
    # API V1 DashboardController
    class DashboardController < Api::V1::ApiController

      api :GET, '/api/v1/dashboard', 'Returns overall rewards overview'
      def show
        render json: current_user, serializer: DashboardSerializer
      end
    end
  end
end

