class User < ActiveRecord::Base

  has_and_belongs_to_many :roles
  has_many :authentications, :dependent => :delete_all

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

  def select_picture(user)
     if !user.picture.present?
      image_tag("http://graph.facebook.com/#{user.uid}/picture?type=normal")
     else
       image_tag(user.picture_url(:profile))
     end
  end
end