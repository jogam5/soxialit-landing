class FixColumnFacebookName < ActiveRecord::Migration
  def change
    rename_column :users, :facebook, :fb
  end
end
