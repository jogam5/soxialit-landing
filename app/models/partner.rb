class Partner < ActiveRecord::Base
  attr_accessible :skype, :paypal, :address, :brand, :category, :city, :email, :name, :phone, :user_id, :website, :zipcode
  belongs_to :user
  
  validates :paypal, :address, :category, :city, :email, :name, :phone, :presence => { :message => "*dato requerido" }, :allow_blank => true
  validates :phone, :numericality => {:message => "*debe ser valor numerico"}
  validates_format_of :email, :paypal, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i 
  
end
