class Reward < ApplicationRecord
  enum status: %i[approved rejected withdrawn pending]

  validates_presence_of :activity_date

  belongs_to :user
  belongs_to :category
  belongs_to :category_reason

  scope :by_date_range, ->(start_date, end_date) { where(activity_date: start_date..end_date) }
  scope :by_category_id, ->(category_id) { where(category: category_id) }
end
