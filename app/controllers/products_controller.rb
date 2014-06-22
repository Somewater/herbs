# encoding: utf-8

class ProductsController < ApplicationController
  before_filter :set_cloud_style

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by_name(params[:id]) || Product.find_by_id(params[:id])
    @section = @product.section
  end

  private
  def set_cloud_style
    @cloud_style = true
  end
end