class Slide < ActiveRecord::Base
  attr_accessible :picture, :post_id
  belongs_to :posts
end
