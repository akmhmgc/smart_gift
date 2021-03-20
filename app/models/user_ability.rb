# frozen_string_literal: true

class UserAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Product, publish: true
    can :manage, Review, user_id: user.id
  end
end
