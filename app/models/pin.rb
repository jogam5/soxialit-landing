class Pin < ActiveRecord::Base
  attr_accessible :description, :gallery_id, :gallery_token, :micropost_id

  belongs_to :gallery 
end
