class AddStatusToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :status, :boolean, :default => true
    add_index :projects, :status
  end
end
