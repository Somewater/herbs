class ProductMainPageField < ActiveRecord::Migration
  def up
    add_column :products, :main_page, :boolean, :default => false
  end

  def down
    remove_column :products, :main_page
  end
end
