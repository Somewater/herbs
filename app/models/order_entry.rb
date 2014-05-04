class OrderEntry < ActiveRecord::Base
  belongs_to :order
  belongs_to :product_cost
  alias_method :cost, :product_cost

  attr_accessible :product_cost_id, :quantity
end
