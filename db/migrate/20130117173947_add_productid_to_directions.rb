class AddProductidToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :product_id, :integer
  end
end
