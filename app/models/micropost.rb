class Micropost < ActiveRecord::Base
  attr_accessible :description, :provider, :thumbnail, :title, :url, :user_id, :status, :picture, :remote_picture_url
  
  belongs_to :user
  has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :sourceships
  has_many :sources, through: :sourceships
  has_reputation :lovs, source: :user, aggregated_by: :sum
  attr_accessible :source_tokens
  attr_reader :source_tokens
  acts_as_taggable_on :source_tokens
  attr_reader :tag_list
  attr_accessible :tag_list
  acts_as_taggable

  mount_uploader :picture, PictureMicropostUploader

  validates :url, presence: true, format: { with: URI::regexp(%w(http https)) }
  
  def source_tokens=(tokens)
     self.source_ids = Source.ids_from_tokens(tokens)
  end
  
  def self.publish_link_facebook(micropost)
    @micropost = micropost
    @user = @micropost.user
      options = {
        :message => "Acabo de compartir un post en Soxialit.",
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
        :message => "Me gusto este post en Soxialit.",
        :picture => @micropost.thumbnail.to_s,
        :link => "http://soxialit.com/microposts/#{micropost.id}",
        :name => "#{@micropost.title} via #{@micropost.provider}",
        :description => @micropost.description
      }
      user.facebook.put_connections("me", "feed", options)
  end

  

end