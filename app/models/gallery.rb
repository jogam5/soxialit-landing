class Gallery < ActiveRecord::Base
  attr_accessible :description, :name, :token, :user_id, :cover

  belongs_to :user
  has_many :pins

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless Gallery.where(token: random_token).exists?
    end
  end
end
