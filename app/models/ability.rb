class Ability
  include CanCan::Ability
 
  def initialize(user)

    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    
    elsif user.role? :designer
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can :create, Product
      can :update, Product do |product|
        product.try(:user) == user
      end
      can :vote, Product
      cannot :vote, Product, :user_id => user.id
      can :read, :all

    elsif user.role? :'fashion lover'
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can :vote, Product
      can :read, :all

    elsif user.role? :'blogger'
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can :vote, Product
      can :read, :all

    elsif user.role? :'fotografo'
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can :vote, Product
      can :read, :all

    elsif user.role? :'boutique store'
      can :update, User, :id => user.id
      can [:list_items, :favorites, :followers, :following], User
      can :create, Product
      can :update, Product do |product|
        product.try(:user) == user
      end
      can :vote, Product
      cannot :vote, Product, :user_id => user.id
      can :read, :all

    else
      can :read, :all
      can [:list_items, :favorites, :followers, :following], User
    end
  end
end