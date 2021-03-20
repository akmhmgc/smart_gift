class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_ability
    @current_ability ||= if user_signed_in?
                           ::UserAbility.new(current_user)
                         elsif store_signed_in?
                           ::StoreAbility.new(current_store)
                         else
                           ::Ability.new(nil)
                         end
  end
end
