class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :boolean, :default => true
    add_index :users, :status
  end
end
