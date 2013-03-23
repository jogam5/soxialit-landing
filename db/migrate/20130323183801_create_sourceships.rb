class CreateSourceships < ActiveRecord::Migration
  def change
    create_table :sourceships do |t|
       t.belongs_to :micropost
       t.belongs_to :source
      t.timestamps
    end
    add_index :sizeships, :micropost_id
    add_index :sizeships, :source_id
  end
end
