class AddShipToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ship_df, :decimal
  end
end
