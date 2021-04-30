# frozen_string_literal: true
module Api
  module V1
    # API V1 NotificationsController
    class NotificationsController < Api::V1::ApiController

      api :GET, '/v1/notifications', 'List all Notifications'
      def index
        @notifications = current_user.notifications.by_recently_created
        meta = {
          total_count: @notifications.count,
          current_page: page,
          per_page: per_page
        }
        @notifications = @notifications.page(page).per(per_page)
        render json: { meta: meta }.merge(serialized_notifications(@notifications)), status: :ok
      end

      private

      def serialized_notifications(notifications)
        ActiveModel::ArraySerializer.new(
          notifications,
          each_serializer: NotificationSerializer,
          root: 'notifications'
        ).as_json
      end
    end
  end
end
