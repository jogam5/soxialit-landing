class Ability
  include CanCan::Ability
 
  def initialize(user)

    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    elsif user.role? :designer
      can :update, User, :id => user.id  #Edit its profile info
      can :read, :all
    elsif user.role? :'fashion lover'
      can :update, User, :id => user.id
      can :read, :all
    elsif user.role? :'blogger'
      can :update, User, :id => user.id
      can :read, :all
    elsif user.role? :'boutique'
      can :update, User, :id => user.id
      can :read, :all
    end
  end
end