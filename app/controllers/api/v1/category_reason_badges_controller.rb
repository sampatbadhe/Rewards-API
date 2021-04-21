# frozen_string_literal: true
module Api
  module V1
    # API V1 CategoryReasonBadgesController
    class CategoryReasonBadgesController < Api::V1::ApiController

      api :GET, '/v1/category_reason_badges', 'List all CategoryReasonBadge'
      def index
        render json: CategoryReasonBadge.page(page).per(per_page), status: :ok
      end
    end
  end
end
