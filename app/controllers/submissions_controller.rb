class SubmissionsController < ApplicationController

  def index
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = @current_user.submissions.build(params[:submission])
    if @submission.save
      flash[:success] = "Your submission has been added"
      redirect_to root_path
    else
      flash[:error] = "There was a problem adding your submission"
      render :new
    end
  end

  # user_submissions
  # ================
  # Displays a list of all the current users submissions
  def user_submissions
    @submissions = @current_user.submissions.all
  end

  def view
  end

  def destroy
  end

end