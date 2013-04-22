class AddCoverToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :cover, :string
  end
end
