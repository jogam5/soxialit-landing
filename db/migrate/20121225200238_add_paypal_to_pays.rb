class AddPaypalToPays < ActiveRecord::Migration
  def change
    add_column :pays, :paypal_customer_token, :string
    add_column :pays, :paypal_recurring_profile_token, :string
  end
end
