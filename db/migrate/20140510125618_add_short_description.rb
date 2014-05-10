class AddShortDescription < ActiveRecord::Migration
  def up
    add_column :products, :short_description_ru, :text
    add_column :products, :short_description_en, :text
  end

  def down
    remove_column :products, :short_description_ru
    remove_column :products, :short_description_en
  end
end
