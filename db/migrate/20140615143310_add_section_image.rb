class AddSectionImage < ActiveRecord::Migration
  def up
    add_column :sections, :image_id, :integer
  end

  def down
    remove_column :sections, :image_id
  end
end
