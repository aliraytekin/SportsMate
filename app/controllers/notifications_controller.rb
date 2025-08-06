class NotificationsController < ApplicationController
  def mark_as_read
    current_user.received_notifications.where(read: false).find_each do |notification|
      notification.update!(read: true)
    end

    unread_count = current_user.received_notifications.where(read: false).count

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "notifications_badge",
          partial: "notifications/badge",
          locals: { unread_count: unread_count }
        )
      }
      format.html { head :ok }
    end
  end
end
