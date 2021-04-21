class CategoryReasonBadgeSerializer < ActiveModel::Serializer
  attributes :id
  has_one :category
  has_one :category_reason
  has_one :badge
end
