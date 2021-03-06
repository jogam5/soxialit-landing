class Product < ActiveRecord::Base

  ENV["APP_ID"] = '439343236107925'
  ENV["APP_SECRET"] = 'fb1c82f1f5893548e750e18e0b67362e'
  ENV["MAILCHIMP_API_KEY"] = '8acea2d56fff73cbaa8a707bf2d2d880-us5'

  attr_accessible :name
  attr_accessible :size_tokens
  attr_accessible :created_at
  attr_accessible :brand, :description, :picture, :title, :user_id, :shipping, :total_price, :ship_int, 
                    :ship_df, :color, :material, :quantity, :refund_policy, :size, :price
  attr_accessible :tipo_envio, :peso, :alto, :largo, :ancho, :price_estafeta, :delivery_time
  attr_accessible :tag_list
  attr_accessible :url
  attr_accessible :name, :image
  attr_accessible :ships_attributes
  attr_accessible :status
  attr_reader :size_tokens
  attr_reader :tag_list
  attr_accessor :paypal_payment_token
  attr_accessor :email

  belongs_to :user
  has_reputation :votes, source: :user, aggregated_by: :sum, :order => "created_at DESC"
  has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :paintings, :dependent => :destroy
  has_many :ships, :dependent => :destroy
  has_many :pays, :dependent => :destroy
  has_many :sizeships
  has_many :sizes, through: :sizeships
  
  accepts_nested_attributes_for :ships

  acts_as_taggable
=begin
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}, :on => :update
  validates_numericality_of :quantity, :greater_than => 0, :less_than => 6, :on => :update    
  validates :quantity, :presence => {:message => "*debe ser menor 6"}, :on => :update
  validates :price, :color, :description, :material, :refund_policy, :title, :brand, :presence => { :message => "*dato requerido" },
   :allow_blank => true, :on => :update
  validates :picture, :presence => {:message => "*el producto debe tener al menos una foto"}, :on => :update
  validates :price, :numericality => {:message => "*debe ser valor numerico"}, :on => :update
  validates :delivery_time, :presence => {:message => "*dato requerido"}, :on => :update
  validates_numericality_of :delivery_time, :greater_than => 0, :less_than => 11, :on => :update    
  validates :ship_df, :ship_int, :tipo_envio, :presence => { :message => "*seleciona al menos una opcion de envio" }, 
  :allow_blank => true, :on => :update, :if => :any_present?
  validates :picture, :presence => {:message => "*debes elegir cual es la imagen principal del producto."}, :on => :update
=end
  default_scope order: 'products.created_at DESC'
  
  def any_present?
    if %w(ship_df tipo_envio ship_int).all?{|attr| self[attr].blank?}
      message = ("*seleciona al menos una opcion de envio")
    end
  end
  
  def size_tokens=(tokens)
     self.size_ids = Size.ids_from_tokens(tokens)
  end
  
  def mercadopago_url(datos)
   client_id = '4268569064335968'
   client_secret = 'pa6nV2JXuGee00YUoXaHsI3fPGhUfNTc'
   mp_client = MercadoPago::Client.new(client_id, client_secret)
   payment = mp_client.create_preference(datos) 
  end
  
  def payment_provided?
     paypal_payment_token.present?
  end

  def self.publish_product_facebook(product)
    Rails.logger.info(product)
    logger.debug "Product no sirve #{product}"
    @user = product.user
      options = {
        :message => "Acabo de publicar un item en Soxialit.",
        :picture => product.picture.to_s,
        :link => "https://soxialit.com/products/#{product.id}",
        :name => "#{product.title} by #{product.user.nickname}",
        :description => product.description
      }
      @user.facebook.put_connections("me", "feed", options)
  end

  def self.publish_product_like_facebook(product, user)
    Rails.logger.info(product)
    logger.debug "Product like no sirve #{product}"
      options = {
        :message => "A #{user.nickname} le gusta un item en Soxialit.",
        :picture => product.picture.to_s,
        :link => "https://soxialit.com/products/#{product.id}",
        :name => "#{product.title} by #{product.user.nickname}",
        :description => product.description
      }
      user.facebook.put_connections("me", "feed", options)
  end
end