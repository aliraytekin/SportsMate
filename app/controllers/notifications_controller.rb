class NotificationsController < ApplicationController
  def mark_as_read
    current_user.received_notifications.where(read: false).update_all(read: true)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "notification_badge",
          partial: "notifications/badge",
          locals: { unread_count: 0 }
        )
      end
      format.html { head :ok }
    end
  end
end
