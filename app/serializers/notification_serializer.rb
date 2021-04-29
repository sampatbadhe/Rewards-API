class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :body, :seen, :recipient_id, :sender_id, :alertable_type, :alertable_id
end
