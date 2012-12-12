class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.decimal :ship_selected
      t.string :ship_name
      t.integer :product_id

      t.timestamps
    end
    add_index :ships, :product_id
  end
end
