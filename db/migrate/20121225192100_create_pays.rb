class CreatePays < ActiveRecord::Migration
  def change
    create_table :pays do |t|
      t.integer :plan_id
      t.string :email

      t.timestamps
    end
  end
end
