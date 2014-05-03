class BasketController < ApplicationController

  attr_reader :basket
  before_filter :create_basket

  def add
    basket.add(params[:product_id].to_i, params[:cost_id].to_i, params[:quantity].to_i)
    render_response
  end

  def remove
    basket.remove(params[:product_id].to_i, params[:cost_id].to_i, params[:quantity].to_i)
    render_response
  end

  def clear
    basket.clear
    if request.xhr?
      render_response
    else
      redirect_to basket_show_path
    end
  end

  def show
    if request.xhr?
      render json: basket.to_json
    end
  end

  def apply
    flash.notice = t('basket.order_assepted')
    # todo: save order
    basket.clear
    render :show
  end

  private
  def create_basket
    @basket = Basket.new(session)
  end

  def render_response
    if request[:render]
      render :show, layout: false
    else
      head :ok
    end
  end
end
