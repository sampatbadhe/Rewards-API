class CategoryReason < ApplicationRecord
  enum status: %i[gold silver bronze]

  belongs_to :category
end
