# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :google_uid
  validates_presence_of :email

  has_many :rewards, dependent: :destroy
  has_many :notifications, class_name: 'Notification', foreign_key: :recipient_id, inverse_of: :recipient

  def self.register_user(params)
    email, first_name, last_name, google_uid = params.values_at(:email, :first_name, :last_name, :google_uid)

    raise ApiErrors::MissingParamsError.new('email/first_name/mobile/google_uid') if email.blank? || first_name.blank? || last_name.blank?

    user = User.find_by(google_uid: google_uid)
    return user if user.present?

    user = User.new(params)
    user.save!
    user
  end

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  # returns user's gravatar photo url
  def photo_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png"
  end

  # returns top contributors in descending order of their contribution
  # Badges have value assigned to it { Gold => 3, Silver => 2, Bronze => 1 }
  # Based on the sum of badges value user will be listed on top.
  def self.top_contributors
    joins(rewards: :category_reason )
      .where(rewards: { status: :approved })
      .select(:id, :first_name, :last_name, :email)
      .select('SUM(category_reasons.badge) as badges_sum')
      .select('COUNT(category_reasons.badge) as badges_count')
      .order('badges_sum DESC')
      .group('users.id')
  end

  # Assign rank to contributors based on badges value.
  def self.top_contributors_by_rank
    top_contributors
      .select("DENSE_RANK() OVER (ORDER BY SUM(category_reasons.badge) DESC) AS rank")
  end

  # returns top contributors of last month span
  def self.heroes_of_the_last_month
    top_contributors
      .where("rewards.activity_date >= ?", 1.month.ago.to_date)
  end
end
