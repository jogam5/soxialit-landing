class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.integer :user_id
      t.string :zipcode

      t.timestamps
    end
    add_index :directions, :user_id
  end
end
