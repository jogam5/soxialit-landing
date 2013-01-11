class AddStatusToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :status, :boolean, :default => false
    add_index :posts, :status
  end
end