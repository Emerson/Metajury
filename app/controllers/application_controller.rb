class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_admin
  helper_method :current_user, :require_admin, :admin_layout

  def current_user
    logger.info "Calling current user"
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end


  def require_admin
    self.current_user
    if controller_path.match(/admin/i)
      if @current_user.blank? or !@current_user.admin?
        flash[:error] = 'Oops, there seems to have been a problem'
        redirect_to root_path
        return
      end
    end
  end


  def admin_layout
    if controller_path.match(/admin/i)
      layout 'admin'
    end
  end

end
