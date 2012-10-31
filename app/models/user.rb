class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
              :username, :picture, :location, :website, :bio, :role_ids

  has_many :authentications, :dependent => :delete_all

  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.username = auth['extra']['raw_info']['first_name']
    self.picture = auth['info']['image']
    self.email = auth['extra']['raw_info']['email']
    self.password = Devise.friendly_token[0,20]
    # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end

  def role?(role)
    return self.roles.find_by_name(role).try(:name) == role.to_s
    #return self.roles.exists?(:name => role.to_s) #ALTERNATIVE
  end
end