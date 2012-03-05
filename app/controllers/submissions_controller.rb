class SubmissionsController < ApplicationController

  before_filter :require_logged_in_user, :except => :index

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

  def upvote
    session[:return_to] ||= request.referer
    @submission = Submission.find(params[:id])
    if @current_user.vote(:up, @submission)
      flash[:notice] = "You have upvoted a story"
    else
      if @current_user.voted?(:up, @submission)
        flash[:alert] = "You can only upvote a submission once"
      else
        flash[:alert] = "You cannot upvote that story"
      end
    end
    redirect_to session[:return_to]
  end

  def downvote
    session[:return_to] ||= request.referer
    @submission = Submission.find(params[:id])
    if @current_user.vote(:down, @submission)
      flash[:notice] = "You have upvoted a story"
    else
      if @current_user.voted?(:down, @submission)
        flash[:alert] = "You can only downvote a submission once"
      else
        flash[:alert] = "You cannot downvote that story"
      end
    end
    redirect_to session[:return_to]
  end
end