class ApplicationController < ActionController::API
  include ActionController::Helpers
  include TokenValidatable

  helper_method :current_user

  private

  def current_user

  end
end
