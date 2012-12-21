class Micropost < ActiveRecord::Base
  attr_accessible :description, :provider, :thumbnail, :title, :url, :user_id, :status
  
  belongs_to :user
  has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :url, presence: true, format: { with: URI::regexp(%w(http https)) }
  
  has_reputation :lovs, source: :user, aggregated_by: :sum
  
end