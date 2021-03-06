class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_and_belongs_to_many :roles
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :followed_users, through: :relationships, source: :followed
  has_many :products, :dependent => :destroy, :order => "created_at DESC"
  has_many :evaluations, class_name: "RSEvaluation", as: :source, :order => "created_at DESC"
  #has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy
  has_many :partners, :dependent => :destroy
  has_many :microposts, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  has_many :pictures, :through => :projects
  has_one :direction, :dependent => :destroy
  has_one :notification, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :galleries, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships

 # has_reputation :votes, source: {reputation: :votes, of: :products}, aggregated_by: :sum, :order => "created_at DESC"
  #has_reputation :haves, source: {reputation: :haves, of: :products}, aggregated_by: :sum
  has_reputation :lovs, source: {reputation: :lovs, of: :microposts}, aggregated_by: :sum
  has_reputation :likes, source: {reputation: :likes, of: :posts}, aggregated_by: :sum
  has_reputation :votes, source: {reputation: :votes, of: :microposts}, aggregated_by: :sum
  #has_reputation :ups, source: {reputation: :ups, of: :microposts}, aggregated_by: :sum

  #has_reputation :user_votes, source: {reputation: :votes, of: :microposts}, aggregated_by: :sum

  mount_uploader :picture, ProfilePictureUploader
  mount_uploader :cover, CoverPictureUploader
  mount_uploader :biopic, BiografiaPictureUploader

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
              :username, :picture, :picture_cache, :location, :website, :bio, 
              :role_ids, :provider, :uid, :token, :nickname, :fb, :status, :cover, :biopic

  #VALID_USERNAME_REGEX = /^[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9_]*$/
  #validates :username, presence: true,  format: { with: VALID_USERNAME_REGEX },
           # uniqueness: { case_sensitive: false }

  before_save {  self.username.downcase! }
  after_create :add_user_to_mailchimp
  #before_destroy :remove_user_from_mailchimp

  def role?(role)
    return self.roles.find_by_name(role).try(:name) == role.to_s
    #return self.roles.exists?(:name => role.to_s) #ALTERNATIVE
  end

  def must_have_one_role
     if role_ids.count == 0
       errors.add(:base, 'Elige un perfil: designer, blogger, boutique, fotografo o fashion lover.')
     end
     errors.add(:base, 'Solamente puedes elegir un rol') if role_ids.count > 1
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username:"usuario"+rand(9).to_s+rand(9).to_s+rand(9).to_s,
                          nickname:auth.info.name,
                          picture:auth.info.image,
                          provider:auth.provider,
                          uid:auth.uid,
                          token:auth.credentials.token,
                          email:auth.info.email,
                          website:"http://",
                          password:Devise.friendly_token[0,10]
                           )
      user.update_attributes(role_ids:"6")
      user.build_notification
      user.follow!(User.find(1))
      user.subscribe!(Group.find(1)) #Every user is subscribed to main Group
      #user.save(:validate => false)
      #user.activities.create(:user_id => user.id, :action => "create")

        @api = Koala::Facebook::API.new(user.token)
        begin 
          options = {
            :message => "Me acabo de unir a Soxialit, la Red Social que conecta Fashion 
            Lovers. Registrate en: http://soxialit.com",
            :picture => "http://24.media.tumblr.com/54465c721550d83d6ff4485a014b0424/tumblr_mdq2fja5Ws1rv5ghbo2_r1_1280.jpg",
            :link => "http://soxialit.com",
            :name => "Soxialit es una red social que conecta a los amantes de la Moda",
            :description => "Comparte posts, items y fotos: deja que el mundo conozca tu talento y pasion por la moda."
          }

          @api.put_connections("me", "feed", options)
          @friends = @api.get_connections("me", "friends")
          @users = User.all
          @users.each do |u|
            @friends.each do |friend|
              if friend["id"] == u.uid
                if u.id != User.find(1).id
                  user.follow!(User.find(u.id))
                  usuario = User.find(u.id)
                  UserMailer.followers(usuario, user).deliver
                end
              end
            end
          end

          rescue Exception=>ex
              puts ex.message
        end
      #User.find(1).follow!(user)
    end

    user.update_attributes(token:auth.credentials.token)
    #user.save(:validate => false)
    user.build_notification unless !user.notification.nil?
    user
  end

  def following? (other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
   
  def voted_for?(haiku)
      evaluations.where(target_type: haiku.class, target_id: haiku.id).present?
  end
  
  def vote_evaluation(micropost, user)
    a = micropost.evaluations
    a.each do |eval|
      return eval.value if (eval.source_id == user.id && eval.reputation_name == "votes")
    end
  end

  def voted_by?(haiku, eva)
     haiku.each do |test|
        if test.target_id == eva
           return test.target_id
        end
    end
  end

  def add_user_to_mailchimp
      mailchimp = Hominid::API.new(ENV["MAILCHIMP_API_KEY"])
      list_id = mailchimp.find_list_id_by_name "Soxialit Registros"
      info = { 'FNAME' => self.nickname }
      result = mailchimp.list_subscribe(list_id, self.email, info, 'html', false, true, false, true)
      Rails.logger.info("MAILCHIMP SUBSCRIBE: result #{result.inspect} for #{self.email}")
  end
  
  def remove_user_from_mailchimp
    unless self.email.include?('@example.com')
      mailchimp = Hominid::API.new(ENV["MAILCHIMP_API_KEY"])
      list_id = mailchimp.find_list_id_by_name "Soxialit Registros"
      result = mailchimp.list_unsubscribe(list_id, self.email, true, false, true)  
      Rails.logger.info("MAILCHIMP UNSUBSCRIBE: result #{result.inspect} for #{self.email}")
    end
  end

  def feed
    @feed = Activity.from_users_followed_by(self).order("created_at DESC").limit(100)
  end

  def self.feed_cached(current_user)
    user = current_user
    Rails.cache.fetch("feed_user_#{user.id}") { user.feed }
  end

  def friends
    User.all.shuffle.take(24)
  end

  def to_param
    username
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info. e.to_s
    nil
  end

  #Check if thee user is already a member of a Group
  def subscribed?(group)
    memberships.find_by_group_id(group.id)
  end

  #The member is added to a Group
  def subscribe!(group)
    memberships.create!(group_id: group.id)
  end

  #The member is removed from a Group
  def unsubscribe!(group)
    memberships.find_by_group_id(group.id).destroy
  end
  
end