class Notification < ApplicationRecord

  validates :body, presence: true

  belongs_to :alertable, polymorphic: true
  belongs_to :recipient, class_name: 'User', inverse_of: :notifications
end
