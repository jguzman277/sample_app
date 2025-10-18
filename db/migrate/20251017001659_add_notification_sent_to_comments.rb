class AddNotificationSentToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :notification_sent, :boolean, default: false
    add_column :comments, :notification_read, :boolean, default: false
  end
end
