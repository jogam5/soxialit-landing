class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.integer :phone
      t.string :category
      t.string :brand
      t.string :website
      t.string :city
      t.string :address
      t.string :zipcode

      t.timestamps
    end
    add_index :partners, :user_id
    
  end
end
