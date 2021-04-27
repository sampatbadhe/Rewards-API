# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :google_uid
  validates_presence_of :email

  has_many :rewards, dependent: :destroy

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
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
