class Reward < ApplicationRecord
  validates_presence_of :activity_date

  belongs_to :user
  belongs_to :category
  belongs_to :category_reason
  belongs_to :claim_grant_status
end
