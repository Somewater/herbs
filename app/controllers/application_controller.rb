class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :reload_settings

  private
  def reload_settings
    Setting.reload
  end
end
