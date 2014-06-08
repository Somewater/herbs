class BasketController < ApplicationController

  attr_reader :basket
  before_filter :create_basket

  include ApplicationHelper

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

  def register
  end

  def apply
    begin
      raise t('basket.basket_empty_error') if basket.empty?
      customer = Customer.where(['lower(email) = ?', params[:email].to_s.downcase]).first
      if customer
        customer.name = params[:name] #if params[:name].present?
        customer.phone = params[:phone] #if params[:phone].present?
        customer.save! if customer.changed?
      else
        customer = Customer.create!(name: params[:name], phone: params[:phone]){|c| c.email = params[:email].to_s.downcase }
      end

      order = basket.create_order(customer, address: params[:address], comment: params[:comment])
    rescue
      alert = $!.to_s
      alert = to_russian_errors($!.record.errors) if $!.is_a? ActiveRecord::RecordInvalid
      flash.alert = alert
      render :register
      return
    end

    OrderMailer.order_created_manager_notify(order).deliver
    OrderMailer.order_created_customer_notify(order).deliver
    basket.clear
  end

  private
  def create_basket
    @basket = Basket.new(session)
  end

  def render_response
    if params[:render].to_s[0] == 't'
      render :show, layout: false
    else
      head :ok
    end
  end
end
