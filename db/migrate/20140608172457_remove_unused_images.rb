class RemoveUnusedImages < ActiveRecord::Migration
  def up
    remove_column :products, :image_2_id, :image_3_id, :image_4_id, :image_5_id
    add_column :products, :image_card_id, :integer
    add_column :products, :image_main_page_id, :integer
  end

  def down
    railse 'Unimplemented'
  end
end
