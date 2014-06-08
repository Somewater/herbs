class MainPageController < ApplicationController
  def index
    @section = Section.main
    @cloud_style = false
  end

  def not_found
    @cloud_style = false
  end
end
