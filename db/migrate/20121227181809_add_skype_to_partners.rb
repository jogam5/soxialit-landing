class AddSkypeToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :skype, :string
  end
end
