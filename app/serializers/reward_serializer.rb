class RewardSerializer < ActiveModel::Serializer
  attributes :id, :activity_date, :category_id, :category_reason_id, :badge_id,
             :comments, :status, :created_at, :updated_at
end
