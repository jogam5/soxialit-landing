class Micropost < ActiveRecord::Base
  attr_accessible :description, :provider, :thumbnail, :title, :url, :user_id, :status, :picture, 
                    :remote_picture_url, :group_id
  scope :since, lambda {|time| where("created_at > ?", time) }
  
  belongs_to :user
  belongs_to :group
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
  has_reputation :votes, source: :user, aggregated_by: :sum

  #has_reputation :votes, source: :user, aggregated_by: :sum, source_of: [{ :reputation => :user_votes, :of => :user }] 
  mount_uploader :picture, PictureMicropostUploader

  validates :url, presence: true, :allow_blank => true, format: { with: URI::regexp(%w(http https)) }
  validates :thumbnail, :length => {:minimum => 10, :too_short => "Por favor agrega una imagen a tu historia."}, :on => :update
  validates :title, :presence => {:message => "Escribe el titulo de tu historia."}, :on => :update
  #validates :url, :length => { :in => 0..255 }, :allow_nil => true, :allow_blank => true

  def reputation(micropost)
    evaluation = []
    micropost.evaluations.each do |voto|
        if voto.reputation_name == "votes"
          evaluation << voto.value
        end
    end
      evaluation.inject{|sum, x| sum + x}.to_i
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