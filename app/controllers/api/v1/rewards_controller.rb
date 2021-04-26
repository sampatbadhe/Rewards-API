# frozen_string_literal: true
module Api
  module V1
    # API V1 RewardsController
    class RewardsController < Api::V1::ApiController
      before_action :set_reward, only: [:show, :update]

      api :GET, '/v1/rewards', 'List all rewards'
      def index
        @rewards = current_user.rewards
        apply_filters
        render json: @rewards.page(page).per(per_page), status: :ok
      end

      api :POST, '/v1/rewards', 'Create a reward'
      def create
        @reward = current_user.rewards.pending.new(reward_params)
        if @reward.save
          render json: @reward, status: :created
        else
          render json: @reward.errors, status: :unprocessable_entity
        end
      end

      api :GET, '/v1/rewards/1', 'Get a reward'
      def show
        render json: @reward, status: :ok
      end

      api :PUT, '/v1/rewards/1', 'Update a reward'
      def update
        if @reward.update(reward_params)
          render json: @reward, status: :updated
        else
          render json: @reward.errors, status: :unprocessable_entity
        end
      end

      api :GET, '/v1/rewards/my_view', 'Returns current user rewards details'
      def my_view
        render json: current_user, serializer: my_view_serializer
      end

      private

      def apply_filters
        status_filter = params[:status].presence
        if ['pending', 'not_pending'].include?(status_filter)
          @rewards = @rewards.send(status_filter)
        end

        start_date = params[:start_date]&.to_date
        end_date = params[:end_date]&.to_date || start_date

        if start_date && end_date
          @rewards = @rewards.by_date_range(start_date, end_date)
        end

        category_id = params[:category_id].presence

        if category_id
          @rewards = @rewards.by_category_id(category_id)
        end
      end

      def set_reward
        @reward = current_user.rewards.find(params[:id])
      end

      def reward_params
        params.require(:reward).permit(:activity_date, :category_id,
          :category_reason_id, :comments, :status)
      end

      def my_view_serializer
        MyViewSerializer
      end
    end
  end
end
