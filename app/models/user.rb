class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy

  # REMOVE THIS LINE - it references Noticed gem
  # has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"

  # Get unread comment notifications count
  def unread_comment_notifications_count
    Comment.unread_notifications.for_user(self).count
  end

  # Get unread comment notifications
  def unread_comment_notifications
    Comment.unread_notifications.for_user(self).order(created_at: :desc)
  end

  # Get all comment notifications (read and unread)
  def all_comment_notifications
    Comment.for_user(self).where(notification_sent: true).order(created_at: :desc)
  end

  # Mark all comment notifications as read
  def mark_all_comment_notifications_as_read!
    Comment.unread_notifications.for_user(self).update_all(notification_read: true)
  end

  # Clear all comment notifications
  def clear_all_comment_notifications!
    Comment.for_user(self).where(notification_sent: true).update_all(
      notification_sent: false,
      notification_read: false
    )
  end
end