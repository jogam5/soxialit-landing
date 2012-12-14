class Product < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :size_tokens
  attr_accessible :brand, :description, :picture, :title, :user_id, :shipping, :total_price, :ship_int, 
                    :ship_df, :color, :material, :quantity, :refund_policy, :size, :price
  attr_accessible :tipo_envio, :peso, :alto, :largo, :ancho, :price_estafeta
  attr_accessible :tag_list
  attr_accessible :name, :image
  attr_accessible :ships_attributes
  attr_accessible :status
  attr_reader :size_tokens
  attr_reader :tag_list
  
  belongs_to :user
  has_reputation :votes, source: :user, aggregated_by: :sum
  has_reputation :haves, source: :user, aggregated_by: :sum
  has_many :activities, :as => :activitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :sizes, :dependent => :destroy
  has_many :paintings, :dependent => :destroy
  has_many :ships, :dependent => :destroy
  
  accepts_nested_attributes_for :ships

  acts_as_taggable
  
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}, :on => :update
  validates_numericality_of :quantity, :greater_than => 0, :less_than => 6, :on => :update    
  validates :color, :description, :material, :refund_policy, :title, :brand, :presence => { :message => "*dato requerido" },
   :allow_blank => true, :on => :update
  
  
  default_scope order: 'products.created_at DESC'
  
  def size_tokens=(tokens)
     self.size_ids = Size.ids_from_tokens(tokens)
  end
  
  def mercadopago_url(datos)
       client_id = '4268569064335968'
       client_secret = 'pa6nV2JXuGee00YUoXaHsI3fPGhUfNTc'
       mp_client = MercadoPago::Client.new(client_id, client_secret)
       payment = mp_client.create_preference(datos) 
  end
end