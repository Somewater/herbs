# encoding: utf-8

class SectionsController < ApplicationController
  before_filter :set_cloud_style

  def show
    @page_idx = params[:page].to_i
    @section = Section.find_by_name(params[:id])
    @pages_count = (@section.products.count.to_f / Section::PER_PAGE).ceil
    @products = @section.products_page(@page_idx, params[:sort].to_s.downcase == 'asc' ? 'asc' : 'desc')
    if request.xhr?
      render partial: 'products/collection', layout: false
    end
  end

  private
  def set_cloud_style
    @cloud_style = true
  end
end