class Post < ActiveRecord::Base
  attr_accessible :body, :quote, :title, :url, :user_id, :status
  has_many :slides
  belongs_to :user
  has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :body, presence: true, 
  				length: { maximum: 550, :too_long => "Vamos, intenta de nuevo: maximo %{count} caracteres." }, 
  					:on => :update
  validates :title, presence: true, :on => :update
  validates :user_id, :presence => true
end