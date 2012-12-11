class Direction < ActiveRecord::Base
  attr_accessible :user_id, :zipcode
  belongs_to :user
end