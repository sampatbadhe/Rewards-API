class Category < ApplicationRecord
  has_many :rewards, dependent: :restrict_with_error
  has_many :category_reasons, dependent: :restrict_with_error
end
