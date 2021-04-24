class CategoryReason < ApplicationRecord
  enum badge: {
    gold: 0,
    silver: 1,
    bronze: 2
  }, _default: 'bronze'

  validates_presence_of :reason
  validates_presence_of :badge

  belongs_to :category

  def name
    reason
  end
end
