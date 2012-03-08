class PagesController < ApplicationController

 def home
  if @current_user
    @submissions = Submission.order('score desc').limit(50).all
    render 'user_homepage'    
  else
    @submissions = Submission.order('score desc').limit(50).all
    render 'homepage'
  end
 end

end