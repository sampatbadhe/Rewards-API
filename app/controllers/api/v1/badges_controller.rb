# frozen_string_literal: true
module Api
  module V1
    # API V1 BadgesController
    class BadgesController < Api::V1::ApiController

      api :GET, '/v1/badges', 'List all badges'
      def index
        render json: Badge.page(page).per(per_page), status: :ok
      end
    end
  end
end
