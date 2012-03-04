class PagesController < ApplicationController

 def home
  if @current_user
    @submissions = Submission.all
    render 'user_homepage'    
  else
    @submissions = Submission.all
    render 'homepage'
  end
 end

end