class Ship < ActiveRecord::Base
  attr_accessible :product_id, :ship_name, :ship_selected, :user_id
  belongs_to :product
end
