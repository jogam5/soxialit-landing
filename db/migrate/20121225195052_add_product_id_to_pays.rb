class AddProductIdToPays < ActiveRecord::Migration
  def change
    add_column :pays, :product_id, :integer
  end
end
