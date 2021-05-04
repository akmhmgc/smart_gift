class NotificationsController < ApplicationController
  before_action :authenticate_store!
  def index
    @notifications = current_store.notifications.preload([user: :profile],[:product],[:review]).page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
