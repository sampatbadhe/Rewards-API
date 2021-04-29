class Reward < ApplicationRecord
  enum status: {
    pending: 0,
    approved: 1,
    rejected: 2,
    withdrawn: 3
  }, _default: 'pending'

  validates_presence_of :activity_date
  validates_presence_of :status

  has_many :notifications, as: :alertable, dependent: :destroy

  belongs_to :user
  belongs_to :category
  belongs_to :category_reason

  scope :by_date_range, ->(start_date, end_date) { where(activity_date: start_date..end_date) }
  scope :by_category_id, ->(category_id) { where(category: category_id) }
  scope :by_recently_created, -> { order(created_at: :desc) }

  delegate :badge, to: :category_reason

  after_update :create_notification, if: :approved_or_rejected?

  private

  def changed_status
    saved_changes[:status][1] if saved_changes[:status]
  end

  def approved_or_rejected?
    %w[approved rejected].include?(changed_status)
  end

  def create_notification
    message = "Reward for your #{category.name} contribution to #{category_reason.reason} on #{activity_date.strftime("%B %d, %Y")} has been #{changed_status} by Admin"
    notification = notifications.new(recipient_id: user_id, body: message)
    notification.save
  end
end
