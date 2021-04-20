# frozen_string_literal: true
module Api
  module V1
    # API V1 RewardsController
    class RewardsController < Api::V1::ApiController
      before_action :set_reward, only: [:show, :update]

      api :GET, '/v1/rewards', 'List all rewards'
      def index
        @rewards = current_user.rewards
        render json: @rewards, status: :ok
      end

      api :POST, '/v1/rewards', 'Create a reward'
      def create
        @reward = current_user.rewards.new(reward_params)
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

      private

      def set_reward
        @reward = current_user.rewards.find(params[:id])
      end

      def reward_params
        params.require(:reward).permit(:activity_date, :category_id,
          :category_reason_id, :badge_id, :comments, :claim_grant_status_id)
      end
    end
  end
end
