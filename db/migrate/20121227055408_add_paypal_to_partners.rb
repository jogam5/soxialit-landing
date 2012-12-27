class AddPaypalToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :paypal, :string
  end
end
