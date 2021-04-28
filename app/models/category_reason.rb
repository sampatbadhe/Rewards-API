class CategoryReason < ApplicationRecord
  enum badge: {
    bronze: 1,
    silver: 2,
    gold: 3
  }, _default: 'bronze'

  validates_presence_of :reason
  validates_presence_of :badge

  belongs_to :category
  has_many :rewards, dependent: :restrict_with_error

  def name
    reason
  end
end
