class Product < ActiveRecord::Base
  attr_accessible :brand, :description, :picture, :title, :user_id

  belongs_to :user
  mount_uploader :picture, ProductPictureUploader
  has_reputation :votes, source: :user, aggregated_by: :sum
  has_reputation :haves, source: :user, aggregated_by: :sum
end
