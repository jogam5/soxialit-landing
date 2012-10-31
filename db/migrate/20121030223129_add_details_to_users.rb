class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :picture, :string
    add_column :users, :location, :string
    add_column :users, :website, :string
    add_column :users, :bio, :text
  end
end
