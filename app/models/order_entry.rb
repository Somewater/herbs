class OrderEntry < ActiveRecord::Base
  belongs_to :order
  belongs_to :product_cost
  belongs_to :product
  alias_method :cost, :product_cost

  attr_accessible :product_cost_id, :product_id, :quantity
end
