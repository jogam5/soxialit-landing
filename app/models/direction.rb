class Direction < ActiveRecord::Base
  attr_accessible :user_id, :zipcode, :product_id
  belongs_to :user
end