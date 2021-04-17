# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionController::Helpers
  include TokenValidatable
  skip_before_action :verify_authenticity_token

  helper_method :current_user
  before_action :current_user

  private

  # Read token data from request Authorization header
  # Parse the user_id
  # Assign the current_user
  def current_user
    @current_user ||= read_from_token
  end

  def read_from_token
    return nil unless token.valid? && token_data.present?

    user_id = token.read('user_id')
    user = User.find_by(id: user_id)
    return nil if user.nil?

    user
  end

  def token_data
    token.data && token.data[0]['user_id']
  end
end
