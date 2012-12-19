class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :url
      t.string :provider
      t.string :title
      t.text :description
      t.string :thumbnail
      t.integer :user_id

      t.timestamps
    end
    add_index :microposts, :user_id
  end
end
