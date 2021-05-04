class NotificationsController < ApplicationController
  before_action :authenticate_store!
  def index
    @notifications = current_store.notifications.preload([user: {profile: {image_attachment: :blob}}], [:product], [:review]).page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end