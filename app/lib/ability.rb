class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      cannot :with_current_password, User
    elsif user.new_record?
      cannot :manage, :all
    else
      can :with_current_password, User
      can :read, User, :id => user.id
      cannot :change_is_admin, User
      cannot :create, User
      cannot :new, User
      can :update, User, :id => user.id
      can :edit, User, :id => user.id
      cannot :destroy, User
    end
  end
end
