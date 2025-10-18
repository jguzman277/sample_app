class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications, if: :user_signed_in?

  include Pagy::Backend

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :admin, :active])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :admin, :active])
  end

  def set_notifications
    @notifications = current_user.unread_comment_notifications.limit(3)
    @unread_count = current_user.unread_comment_notifications_count
  end
end
