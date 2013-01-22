class Direction < ActiveRecord::Base
  attr_accessible :user_id, :zipcode, :product_id, :name, :street, :suburb, :town, :state
  belongs_to :user
  
  #validates :zipcode, :name, :street, :suburb, :town, :state, :presence => { :message => "*dato requerido" },
   #:allow_blank => true
  
end