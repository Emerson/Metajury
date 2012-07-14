class CommentsController < ApplicationController

  before_filter :require_user, :only => [:create]
  before_filter :load_submission
  before_filter :build_comment

  def index
    @comments = @submission.comments.all
  end

  def new
    respond_to do |format|
      format.js {}
    end
  end

  def create
    @comment.save!
    flash[:success] = "Your comment has been posted"
    redirect_to submission_comments_path(@submission)
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "There was a problem saving your comment"
    redirect_to submission_comments_path(@submission)
  end

private

  def load_submission
    @submission = Submission.find(params[:submission_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "That story has disapeared"
    redirect_to root_path
    return
  end

  def build_comment
    if logged_in?
      if params[:comment]
        params[:comment].merge!({:user_id => @current_user.id})
      else
        params[:comment] = {:user_id => @current_user.id}
      end
      @comment = @submission.comments.build(params[:comment])
      @comment.parent_id = params[:parent_id] if params[:parent_id]
    end
  end
  
  def require_user
    unless logged_in?
      redirect_to root_path
      flash[:error] = "You need to be logged in to do that"
    end
    return
  end

end