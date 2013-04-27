class AddGroupIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :group_id, :integer
    add_index :microposts,:group_id
  end
end
