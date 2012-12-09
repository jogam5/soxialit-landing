class AddActionToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :action, :string
  end
end
