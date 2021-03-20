# frozen_string_literal: true

class StoreAbility
  include CanCan::Ability
  def initialize(store)
    can :read, Product, publish: true
    can :manage, Product, store_id: store.id
  end
end
