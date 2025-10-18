class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # Scopes for notifications
  scope :unread_notifications, -> { where(notification_sent: true, notification_read: false) }
  scope :for_user, ->(user) { joins(:post).where(posts: { user_id: user.id }) }

  # Mark notification as read
  def mark_notification_as_read!
    update(notification_read: true) if notification_sent?
  end

  # Check if notification was sent
  def notification_sent?
    notification_sent == true
  end
end
