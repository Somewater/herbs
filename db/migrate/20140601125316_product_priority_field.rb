class ProductPriorityField < ActiveRecord::Migration
  def up
    add_column :products, :priority, :integer, :default => 0
  end

  def down
    remove_column :products, :priority
  end
end
