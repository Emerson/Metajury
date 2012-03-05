class PagesController < ApplicationController

 def home
  if @current_user
    @submissions = Submission.order('created_at desc').limit(50).all
    render 'user_homepage'    
  else
    @submissions = Submission.order('created_at desc').limit(50).all
    render 'homepage'
  end
 end

end