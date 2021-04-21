# frozen_string_literal: true
module Api
  module V1
    # API V1 CategoryReasonsController
    class CategoryReasonsController < Api::V1::ApiController

      api :GET, '/v1/category_reasons', 'List all CategoryReason'
      def index
        render json: CategoryReason.page(page).per(per_page), status: :ok
      end
    end
  end
end
