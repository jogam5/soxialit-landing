class AddMicropostidToSources < ActiveRecord::Migration
  def change
    add_column :sources, :micropost_id, :integer
  end
end
