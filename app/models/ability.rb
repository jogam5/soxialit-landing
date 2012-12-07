class Ability
  include CanCan::Ability
 
  def initialize(user)

    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    elsif user.role? :designer
      can :manage, :all
    elsif user.role? :'fashion lover'
      can :update, User, :id => user.id
      can :vote, Product
      can :read, :all
    elsif user.role? :'blogger'
      can :update, User, :id => user.id
      can :vote, Product
      can :read, :all
    elsif user.role? :'fotografo'
      can :update, User, :id => user.id
      can :vote, Product
      can :read, :all
    elsif user.role? :'boutique store'
      can :update, User, :id => user.id
      can :vote, Product
      can :read, :all
    end
  end
end