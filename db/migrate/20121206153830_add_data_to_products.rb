class AddDataToProducts < ActiveRecord::Migration
  def change
    add_column :products, :shipping, :decimal
    add_column :products, :total_price, :decimal
    add_column :products, :ship_int, :decimal
    add_column :products, :color, :string
    add_column :products, :material, :string
    add_column :products, :quantity, :integer
    add_column :products, :refund_policy, :text
    add_column :products, :price, :decimal
  end
end
