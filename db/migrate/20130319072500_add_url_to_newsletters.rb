class AddUrlToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :url, :text
  end
end
