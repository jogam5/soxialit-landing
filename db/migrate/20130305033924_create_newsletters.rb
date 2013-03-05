class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :title
      t.text :description
      t.string :imagen

      t.timestamps
    end
  end
end
