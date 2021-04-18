class Reward < ApplicationRecord
  validates_presence_of :activity_date

  belongs_to :user
end
