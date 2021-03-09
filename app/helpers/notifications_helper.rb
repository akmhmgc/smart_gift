module NotificationsHelper
  def unchecked_notifications
    current_store.notifications.where(checked: false)
  end
end
