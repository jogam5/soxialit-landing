class ChangeProviderTypeForMicropost < ActiveRecord::Migration
  def self.up
  	change_table :microposts do |t|
  		t.change :provider, :text, :limit => nil
  		t.change :thumbnail, :text, :limit => nil
  	end
  end

  def self.down
  	change_table :microposts do |t|
  		t.change :provider, :string
  		t.change :thumbnail, :string
  	end
  end
end