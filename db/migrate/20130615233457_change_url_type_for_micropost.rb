class ChangeUrlTypeForMicropost < ActiveRecord::Migration
  def self.up
  	change_table :microposts do |t|
  		t.change :url, :text, :limit => nil
  	end
  end

  def self.down
  	change_table :microposts do |t|
  		t.change :url, :string
  	end
  end
end