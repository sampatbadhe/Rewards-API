class Reward < ApplicationRecord
  enum status: {
    pending: 0,
    approved: 1,
    rejected: 2,
    withdrawn: 3
  }, _default: 'pending'

  validates_presence_of :activity_date
  validates_presence_of :status

  belongs_to :user
  belongs_to :category
  belongs_to :category_reason

  scope :by_date_range, ->(start_date, end_date) { where(activity_date: start_date..end_date) }
  scope :by_category_id, ->(category_id) { where(category: category_id) }
end
