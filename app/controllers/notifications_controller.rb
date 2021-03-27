class NotificationsController < ApplicationController
  before_action :authenticate_store!
  def index
    # current_userの投稿に紐づいた通知一覧
    @notifications = current_store.notifications.includes(%i[user product review]).page(params[:page]).per(20)

    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
