class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user
  helper_method :current_user, :use_admin_layout?, :logged_in?

  def current_user
    if !cookies[:auth_token].blank?
      @current_user ||= User.find_by_auth_token(cookies[:auth_token])
    else
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
    # Add a dynamic method for admin checks if needed
    unless @current_user
      def @current_user.admin?
        return false
      end
    end
    @current_user
  end

  def logged_in?
    @current_user.present?
  end

  def use_admin_layout?
    controller_path.match(/admin/i) && @current_user.admin?
  end

  def require_logged_in_user
    unless @current_user
      flash[:error] = "You must be logged in to do that..."
      redirect_to root_path
    end
  end

end