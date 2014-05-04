# encoding: utf-8

class Basket

  attr_reader :session, :basket
  BASKET = :basket

  delegate :to_json, :present?, :empty?, to: :basket

  def initialize(session)
    @session = session
    @basket = {} # @basket[<product_id>] = {<cost_id> => <quantity>, <cost_id_2> => <quantity_2>}
    load()
  end

  def add product_id, cost_id, quantity
    @basket[product_id] ||= {}
    new_quantity = (@basket[product_id][cost_id] || 0) + quantity
    @basket[product_id][cost_id] = new_quantity
    save
  end

  def remove product_id, cost_id, quantity
    @basket[product_id] ||= {}
    @basket[product_id][cost_id] = (@basket[product_id][cost_id] || 0) - quantity
    @basket[product_id].delete cost_id if @basket[product_id][cost_id] <= 0
    @basket.delete product_id if @basket[product_id].empty?
    save
  end

  def clear
    @basket = {}
    save
  end

  def materialize
    products_ids = Set.new
    costs_ids = Set.new
    @basket.each do|product_id, costs|
      products_ids << product_id
      costs.each do |cost_id, q|
        costs_ids << cost_id
      end
    end

    products_hash = Product.find(products_ids.to_a).group_by(&:id)
    costs_hash = ProductCost.find(costs_ids.to_a).group_by(&:id)

    p_map = @basket.map do|product_id, costs|
      c_map = costs.map do |cost_id, quantity|
        [costs_hash[cost_id].first, quantity]
      end
      [products_hash[product_id].first, Hash[c_map]]
    end

    Hash[p_map]
  end

  def create_order(customer, params = {})
    order = Order.create!(params.merge(customer: customer))
    @basket.each do |product_id, costs|
      costs.each do |cost_id, quantity|
        order.order_entries.create!(product_cost_id: cost_id, quantity: quantity)
      end
    end
    order
  end

  def self.present?(session)
    JSON.load(session[BASKET]).present?
  end

  private
  def save
    session[BASKET] = @basket.to_json
  end

  def load
    @basket = Hash[(JSON.load(session[BASKET]) || {}).map{|p_id, costs| [p_id.to_i, Hash[costs.map{|c_id, q| [c_id.to_i, q] }]] }]
  end
end