class AddDatosPersonalesToDirection < ActiveRecord::Migration
  def change
    add_column :directions, :name, :string
    add_column :directions, :street, :string
    add_column :directions, :suburb, :string
    add_column :directions, :town, :string
    add_column :directions, :state, :string
  end
end
