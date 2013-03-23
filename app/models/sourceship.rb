class Sourceship < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :micropost
  belongs_to :source 
end
