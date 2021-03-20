# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    can :read, Product, publish: true
  end
end
