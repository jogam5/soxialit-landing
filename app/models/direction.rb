class Direction < ActiveRecord::Base
  attr_accessible :user_id, :zipcode, :id
  attr_reader :id
  belongs_to :user
end