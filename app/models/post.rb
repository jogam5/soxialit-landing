class Post < ActiveRecord::Base
  attr_accessible :body, :quote, :title, :url, :user_id, :status
  has_many :slides
  belongs_to :user
  has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :body, presence: true, 
  				length: { maximum: 550, :too_long => "Intenta otra vez: maximo %{count} caracteres." }, 
  					:on => :update
  validates :title, presence: true, :on => :update
  validates :user_id, :presence => true


  def self.publish_post_facebook(post)
    @post = post
    @user = @post.user
    @api = Koala::Facebook::API.new(@user.token)
      begin
        options = {
          :message => "Acabo de publicar un nuevo Micropost en Soxialit.",
          :picture => @post.slides.first.picture.to_s,
          :link => "http://soxialit.com/posts/#{@post.id}",
          :name => "#{@post.title} by #{@post.user.nickname}",
          :description => @post.quote
        }
        @api.put_connections("me", "feed", options)
        rescue Koala::Facebook::APIError => e
            #puts ex.message
          if e.message.include?("OAuthException: Error validating access token: Session does not match current stored session.")
            Rails.logger.error "Facebook access token not valid"
            @api = Koala::Facebook::OAuth.new("235628993153454", "6dc90b8b268f2643ebd5b074a88db7c8")
            @api.exchange_access_token_info(@user.token)
            options = {
              :message => "Acabo de publicar un nuevo Micropost en Soxialit.",
              :picture => @post.slides.first.picture.to_s,
              :link => "http://soxialit.com/posts/#{@post.id}",
              :name => "#{@post.title} by #{@post.user.nickname}",
              :description => @post.quote
            }
            @api.put_connections("me", "feed", options)
          else
            Rails.logger.error "FacebookApi#perform Koala Error with #{e}, model_id:#{model.id}"
          end
      end
  end
end