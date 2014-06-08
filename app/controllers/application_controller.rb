class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :reload_settings
  before_filter :set_cloud_style

  private
  def reload_settings
    Setting.reload
  end

  def set_cloud_style
    @cloud_style = true
  end
end
