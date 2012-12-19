class AddStatusToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :status, :boolean
  	add_index :microposts, :status
  end
end