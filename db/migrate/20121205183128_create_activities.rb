class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :activitable_id
      t.string :activitable_type
      t.integer :user_id

      t.timestamps
    end
    add_index :activities, :user_id
    add_index :activities, :activitable_type
  end
end