class AddFacebookToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook, :boolean, :default => true
    add_index :users, :facebook
  end
end
