module Madmin
  class ApplicationController < Madmin::BaseController
    before_action :authenticate_admin_user

    def authenticate_admin_user
      # Ensure user is signed in with Devise
      authenticate_user!

      # Check if user has admin privileges
      unless current_user.admin?
        redirect_to root_path, alert: "You are not authorized to access the admin area."
      end
    end
  end
end
