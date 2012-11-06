class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :brand
      t.string :description
      t.string :picture
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
