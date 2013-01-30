class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :follow, :default => true
      t.boolean :lov_item, :default => true
      t.boolean :lov_post, :default => true
      t.boolean :lov_micropost, :default => true
      t.integer :user_id, :default => true

      t.timestamps
    end
    add_index :notifications, :user_id
  end
end
