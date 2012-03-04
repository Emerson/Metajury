class PagesController < ApplicationController

 def home
  if @current_user
    render 'user_homepage'    
  else
    render 'homepage'
  end
 end

end