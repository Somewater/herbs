class ProductCosts < ActiveRecord::Migration
  def up
    create_table :product_costs do |t|
      t.integer :cost
      t.integer :amount
      t.integer :weight, :default => 0
      t.timestamps
    end

    add_column :products, :cost_1_id, :integer
    add_column :products, :cost_2_id, :integer
    add_column :products, :cost_3_id, :integer

    Product.find_each do |product|
      cost = ProductCost.create(:cost => product.attributes['cost'])
      product.cost_1_id = cost.id
      product.save
    end

    change_column :products, :cost_1_id, :integer, null: false
    remove_column :products, :cost
  end

  def down
    drop_table :product_costs

    remove_column :products, :cost_1_id
    remove_column :products, :cost_2_id
    remove_column :products, :cost_3_id
    add_column :products, :cost, :integer
  end
end
