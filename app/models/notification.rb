class Notification < ApplicationRecord

  validates :body, presence: true

  belongs_to :alertable, polymorphic: true
end
