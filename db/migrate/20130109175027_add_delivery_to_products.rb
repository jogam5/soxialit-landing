class AddDeliveryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :delivery_time, :string
  end
end
