class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :image
      t.string :name
      t.integer :product_id

      t.timestamps
    end
    add_index :paintings, :product_id
  end
end