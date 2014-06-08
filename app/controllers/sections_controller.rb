# encoding: utf-8

class SectionsController < ApplicationController
  def show
    @page_idx = params[:page].to_i
    @section = Section.find_by_name(params[:id])
    @products = @section.products_page(@page_idx, params[:sort].to_s.downcase == 'asc' ? 'asc' : 'desc')
    if request.xhr?
      render partial: 'products/collection', layout: false
    end
  end
end