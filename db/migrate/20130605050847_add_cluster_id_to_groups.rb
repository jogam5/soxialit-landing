class AddClusterIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :cluster_id, :integer

    add_index :groups, :cluster_id
  end
end
