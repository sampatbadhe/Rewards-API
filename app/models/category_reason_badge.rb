class CategoryReasonBadge < ApplicationRecord
  belongs_to :category
  belongs_to :category_reason
  belongs_to :badge
end
