class PagesController < ApplicationController

 def home
  if @current_user
    @submissions = Submission.paginate(:page => params[:page]).order('score DESC, created_at DESC').all
    render 'user_homepage'    
  else
    @submissions = Submission.paginate(:page => params[:page]).order('score DESC, created_at DESC').all
    render 'homepage'
  end
 end

end