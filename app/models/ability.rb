class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :read, Category # Allow users to read all categories
      can :manage, Category, user_id: user.id # Allow users to manage their own categories
    else
      cannot :manage, Category # Prevent users from managing all categories
    end
  end
end
