class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.string :description
      t.integer :gallery_id
      t.string :gallery_token
      t.integer :micropost_id

      t.timestamps
    end
  end
end
