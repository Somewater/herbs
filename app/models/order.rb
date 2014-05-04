class Order < ActiveRecord::Base

  belongs_to :customer
  has_many :order_entries

  validates :address, presence: true

  attr_accessible :customer, :address, :comment

  def full_cost
    full = 0.0
    order_entries.preload(:product_cost).each do |entry|
      full += entry.cost.cost
    end
    full.to_i
  end

  def materialize
    entries = self.order_entries.preload(:product_cost).to_a
    costs = entries.map{|e| e.product_cost}.uniq
    products = entries.map{|e| e.product}.uniq
    products.inject({}) do |hash, product|
      hash[product] = costs.select{|cost| product.include_cost? cost }.inject({}) do |costs_hash, cost|
        costs_hash[cost] = entries.find{|entry| entry.product_cost_id == cost.id }
        costs_hash
      end
      hash
    end
  end
end
