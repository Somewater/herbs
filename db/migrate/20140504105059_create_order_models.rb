class CreateOrderModels < ActiveRecord::Migration
  def up
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.string :email, null: false
      t.timestamps
    end

    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.text :address
      t.text :comment
      t.timestamps
    end

    create_table :order_entries do |t|
      t.integer :order_id, null: false
      t.integer :product_cost_id, null: false
      t.integer :quantity, default: 1
      t.timestamps
    end

    execute <<-SQL
      CREATE UNIQUE INDEX index_customers_on_email_lower ON customers(lower(email));
    SQL
    add_index :orders, [:customer_id]
    add_index :order_entries, [:order_id]
  end

  def down
    drop_table :order_entries
    drop_table :orders
    drop_table :customers
  end
end
