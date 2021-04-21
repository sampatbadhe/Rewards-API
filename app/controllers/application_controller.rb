# frozen_string_literal: true

class ApplicationController < ActionController::Base

  DEFAULT_PAGE = 1
  def page
    @page ||= params[:page] || DEFAULT_PAGE
  end

  DEFAULT_PER_PAGE = 20
  def per_page
    @per_page ||= params[:per_page] || DEFAULT_PER_PAGE
  end
end
