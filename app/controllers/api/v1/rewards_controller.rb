# frozen_string_literal: true
module Api
  module V1
    # API V1 RewardsController
    class RewardsController < Api::V1::ApiController
      before_action :set_reward, only: %i[show update]

      resource_description do
        short "List, create, update and delete rewards."
        description <<-EOS
          Only rewards associated to the current user are returned.
        EOS
        formats ['json']
        error 401, "Unauthorized"
        error 404, "Not Found"
        error 422, "Validation Error"
        error 500, "Internal Server Error"
      end

      def_param_group :reward do
        param :reward, Hash, required: true do
          param :activity_date, String, desc: "Date when activity was conducted", allow_nil: false
          param :category_id, Integer, desc: "Category ID", allow_nil: false
          param :category_reason_id, Integer, desc: "CategoryReason ID", allow_nil: false
          param :comments, String, desc: "User can add additional comments about activity or reward", allow_nil: true
          param :status, Integer, desc: "enum for specific status", allow_nil: true
        end
      end

      api :GET, '/v1/rewards', 'List all rewards'
      def index
        @rewards = current_user.rewards.by_recently_created
        meta = {
          total_count: @rewards.count,
          current_page: page,
          per_page: per_page
        }
        apply_filters
        render json: { meta: meta }.merge(serialized_rewards(@rewards)), status: :ok
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
          render json: @reward, status: :ok
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
        if %w[pending not_pending].include?(status_filter)
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
        @rewards = @rewards.page(page).per(per_page)
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

      def rewards_serializer
        RewardSerializer
      end

      def serialized_rewards(rewards)
        ActiveModel::ArraySerializer.new(
          rewards,
          each_serializer: rewards_serializer,
          root: 'rewards'
        ).as_json
      end
    end
  end
end
