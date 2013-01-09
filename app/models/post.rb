class Post < ActiveRecord::Base
  attr_accessible :body, :quote, :title, :url, :user_id
  has_many :slides
  belongs_to :user
  has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :body, presence: true, length: { maximum: 750, :too_long => "Intentalo de nuevo: el Micropost debe tener maximo %{count} caracteres." }
  validates :title, presence: true
  validates :user_id, :presence => true
end