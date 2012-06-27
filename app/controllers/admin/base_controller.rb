class Admin::BaseController < ApplicationController

  layout 'admin'

  before_filter :require_admin

private

  def require_admin
    redirect_to root_path unless @current_user.present? && @current_user.admin?
  end

end
