class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # Use the current_user from the connection, not the channel
    if current_user
      stream_for current_user
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
