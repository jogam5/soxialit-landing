class Micropost < ActiveRecord::Base
  attr_accessible :description, :provider, :thumbnail, :title, :url, :user_id, :status
  
  belongs_to :user
  has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :url, presence: true, format: { with: URI::regexp(%w(http https)) }
  
  has_reputation :lovs, source: :user, aggregated_by: :sum

  def self.publish_link_facebook(micropost)
    @micropost = micropost
    @user = @micropost.user
      options = {
        :message => "Acabo de compartir un link en Soxialit.",
        :picture => @micropost.thumbnail.to_s,
        :link => "http://soxialit.com/microposts/#{micropost.id}",
        :name => "#{@micropost.title} via #{@micropost.provider}",
        :description => @micropost.description
      }
      @user.facebook.put_connections("me", "feed", options)
  end

  def self.publish_link_like_facebook(micropost, user)
    @micropost = micropost
      options = {
        :message => "Me gusto el siguiente link en Soxialit.",
        :picture => @micropost.thumbnail.to_s,
        :link => "http://soxialit.com/microposts/#{micropost.id}",
        :name => "#{@micropost.title} via #{@micropost.provider}",
        :description => @micropost.description
      }
      user.facebook.put_connections("me", "feed", options)
  end
end