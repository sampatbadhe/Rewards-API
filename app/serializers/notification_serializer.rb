class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :body, :seen, :recipient_id, :alertable_type, :alertable_id, :created_at
end
