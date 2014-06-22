class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :reload_settings
  before_filter :assign_cloud_style
  before_filter :create_basket

  private
  def reload_settings
    Setting.reload
  end

  def assign_cloud_style
    @cloud_style = false
  end

  def create_basket
    @basket = Basket.new(session)
  end
end
