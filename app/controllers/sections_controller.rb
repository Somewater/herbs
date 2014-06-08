# encoding: utf-8

class SectionsController < ApplicationController
  def show
    @section = Section.find_by_name(params[:id])
    @products = @section.products_page(params[:page] || 0, params[:sort].to_s.downcase == 'desc' ? 'desc' : 'asc')
    if request.xhr?
      render partial: 'products/collection', layout: false
    end
  end
end