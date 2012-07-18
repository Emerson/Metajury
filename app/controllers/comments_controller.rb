class CommentsController < ApplicationController

  before_filter :require_user, :only => [:create, :upvote, :downvote]
  before_filter :load_submission, :except => [:upvote, :downvote]
  before_filter :load_comment, :only => [:upvote, :downvote]
  before_filter :build_comment, :except => [:upvote, :downvote]

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

  def upvote
    response = {}
    if @current_user.vote(:up, @comment)
      response[:status] = 'success'
      response[:message] = 'Comment Upvoted'
    else
      response[:status] = 'error'
      if @current_user.voted?(:up, @comment)
        response[:message] = "You can only upvote a comment once"
      else
        response[:message] = "You cannot upvote that comment"
      end
    end
    response[:updated_count] = @comment.tally
    render :json => response
    return
  end

  def downvote
    response = {}
    if @current_user.vote(:down, @comment)
      response[:status] = 'success'
      response[:message] = 'Comment Downvoted'
    else
      response[:status] = 'error'
      if @current_user.voted?(:down, @comment)
        response[:message] = "You can only downvote a comment once"
      else
        response[:message] = "You cannot downvote that comment"
      end
    end
    response[:updated_count] = @comment.tally
    render :json => response
    return
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
  
  def load_comment
    @comment = Comment.find(params[:id])
  rescue
    ActiveRecord::RecordNotFound
    render :json => {:status => 'error', :message => 'Comment not found'}
    false
  end

  def require_user
    unless logged_in?
      redirect_to root_path
      flash[:error] = "You need to be logged in to do that"
    end
    return
  end

end