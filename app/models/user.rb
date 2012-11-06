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

  mount_uploader :picture, ProfilePictureUploader
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
              :username, :picture, :location, :website, :bio, :role_ids,
              :provider, :uid

  before_save {  self.username.downcase! }

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :must_have_only_one_role

  def role?(role)
    return self.roles.find_by_name(role).try(:name) == role.to_s
    #return self.roles.exists?(:name => role.to_s) #ALTERNATIVE
  end

  def must_have_only_one_role
    errors.add(:base, 'Solamente puedes elegir un rol') unless role_ids.count == 1
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username:auth.extra.raw_info.first_name,
                          picture:auth.info.image,
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20]
                           )
      user.save(:validate => false)
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

   has_reputation :votes, source: {reputation: :votes, of: :products}, aggregated_by: :sum

  def voted_for?(haiku)
          evaluations.where(target_type: haiku.class, target_id: haiku.id).present?
  end

    has_reputation :haves, source: {reputation: :haves, of: :products}, aggregated_by: :sum
end