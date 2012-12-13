class AddUserIdToShips < ActiveRecord::Migration
  def change
    add_column :ships, :user_id, :integer
  end
end
