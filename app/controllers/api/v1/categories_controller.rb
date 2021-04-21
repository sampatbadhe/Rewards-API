# frozen_string_literal: true
module Api
  module V1
    # API V1 CategoriesController
    class CategoriesController < Api::V1::ApiController

      api :GET, '/v1/categories', 'List all categories'
      def index
        render json: Category.page(page).per(per_page), status: :ok
      end
    end
  end
end
