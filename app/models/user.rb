class User < ActiveRecord::Base

  has_and_belongs_to_many :roles
  #has_many :authentications, :dependent => :delete_all
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :followed_users, through: :relationships, source: :followed
  has_many :products, :dependent => :destroy
  has_many :evaluations, class_name: "RSEvaluation", as: :source
  has_many :feedbacks, :dependent => :destroy
  has_reputation :votes, source: {reputation: :votes, of: :products}, aggregated_by: :sum
  has_reputation :haves, source: {reputation: :haves, of: :products}, aggregated_by: :sum

  mount_uploader :picture, ProfilePictureUploader
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
              :username, :picture, :picture_cache, :location, :website, :bio, 
              :role_ids, :provider, :uid, :token

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :must_have_one_role

  before_save {  self.username.downcase! }
  after_create :add_user_to_mailchimp 
  #before_destroy :remove_user_from_mailchimp

  def role?(role)
    return self.roles.find_by_name(role).try(:name) == role.to_s
    #return self.roles.exists?(:name => role.to_s) #ALTERNATIVE
  end

  def must_have_one_role
     if role_ids.count == 0
       errors.add(:base, 'Elige un rol')
     end
     errors.add(:base, 'Solamente puedes elegir un rol') if role_ids.count > 1
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username:auth.extra.raw_info.first_name,
                          picture:auth.info.image,
                          provider:auth.provider,
                          uid:auth.uid,
                          token:auth.credentials.token,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20]
                           )
      user.save(:validate => false)

        @api = Koala::Facebook::API.new(user.token)
          begin
            #@graph_data = @api.get_object("/me/posts")
            #@graph_data = @api.get_object("me/user", "fields" => "id")
           #@graph_data = @api.get_object("/me/")
            @api.put_connections("me", "feed", :message => "Me acabo de unir a Soxialit, la red social 
              que conecta fashion designers, fotografos, bloggers y boutiques en Mexico y 
              Latinoamerica. Registrate en: http://www.soxialit.com")
            #@api.put_wall_post("Test#2 Soxialit App")
            rescue Exception=>ex
                puts ex.message
          end
    end
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

  def add_user_to_mailchimp
      mailchimp = Hominid::API.new(ENV["MAILCHIMP_API_KEY"])
      list_id = mailchimp.find_list_id_by_name "Soxialit Registros"
      info = { 'FNAME' => self.username }
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
end