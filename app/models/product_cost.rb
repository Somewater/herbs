# encoding: utf-8

class ProductCost < ActiveRecord::Base
  belongs_to :product
  attr_accessible :cost, :amount

  rails_admin do
    edit do
      field :cost
      field :amount
    end

    object_label_method do
      :label_method
    end
  end

  def label_method
    "Cost=#{cost}, amount=#{amount}"
  end
end