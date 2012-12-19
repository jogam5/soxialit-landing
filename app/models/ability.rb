class Ability
  include CanCan::Ability
 
  def initialize(user)

    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    
    elsif user.role? :designer
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can [:paypal_checkout, :envio_df, :tallas, :comprar, :envio, :mercadopago_checkout], Product
      can :create, Product
      can :update, Product do |product|
        product.try(:user) == user
      end
      can :destroy, Product do |product|
        product.try(:user) == user
      end
      can :vote, Product
      cannot :vote, Product, :user_id => user.id
      can :products_all, Product
      can :create, Micropost
      can :read, :all

    elsif user.role? :'fashion lover'
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can [:paypal_checkout, :envio_df, :tallas, :comprar, :envio, :mercadopago_checkout], Product
      can :vote, Product
      can :products_all, Product
      can :create, Micropost
      can :read, :all

    elsif user.role? :'blogger'
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can [:paypal_checkout, :envio_df, :tallas, :comprar, :envio, :mercadopago_checkout], Product
      can :vote, Product
      can :products_all, Product
      can :create, Micropost
      can :read, :all

    elsif user.role? :'fotografo'
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can [:paypal_checkout, :envio_df, :tallas, :comprar, :envio, :mercadopago_checkout], Product
      can :vote, Product
      can :products_all, Product
      can :create, Micropost
      can :read, :all

    elsif user.role? :'boutique store'
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can [:paypal_checkout, :envio_df, :tallas, :comprar, :envio, :mercadopago_checkout], Product
      can :create, Product
      can :update, Product do |product|
        product.try(:user) == user
      end
      can :destroy, Product do |product|
        product.try(:user) == user
      end
      can :vote, Product
      cannot :vote, Product, :user_id => user.id
      can :products_all, Product
      can :create, Micropost
      can :read, :all
      
    else
      can :read, :all
      can [:list_items, :favorites, :followers, :following], User
      can [:paypal_checkout, :envio_df, :tallas, :comprar, :envio, :mercadopago_checkout], Product
      can :products_all, Product
    end
  end
end