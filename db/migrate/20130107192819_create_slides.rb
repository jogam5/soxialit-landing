class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :picture
      t.integer :post_id

      t.timestamps
    end
    add_index :slides, :post_id
  end
end