class AddPostionToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :position, :boolean
  end
end
