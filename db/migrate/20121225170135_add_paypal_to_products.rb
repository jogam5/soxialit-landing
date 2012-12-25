class AddPaypalToProducts < ActiveRecord::Migration
  def change
    add_column :products, :paypal_customer_token, :string
    add_column :products, :paypal_recurring_profile_token, :string
  end
end
