class ChangeDataTypeForPartnersPhones < ActiveRecord::Migration
  def up
     change_table :partners do |t|
        t.change :phone, :string
      end
  end

  def down
     change_table :partners do |t|
        t.change :phone, :integer
      end
  end
end


