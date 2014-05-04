class AddProductReferenceToOrder < ActiveRecord::Migration
  def up
    add_column :order_entries, :product_id, :integer, null: false
  end

  def down
    remove_column :order_entries, :product_id
  end
end
