class AddBiopicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :biopic, :string
  end
end