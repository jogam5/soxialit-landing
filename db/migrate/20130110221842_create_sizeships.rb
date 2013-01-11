class CreateSizeships < ActiveRecord::Migration
  def change
    create_table :sizeships do |t|
       t.belongs_to :product
       t.belongs_to :size
      t.timestamps
    end
    add_index :sizeships, :product_id
    add_index :sizeships, :size_id
  end
end
