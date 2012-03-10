class CommentsController < ApplicationController

  def index
    @submission = Submission.find(params[:submission_id])
    @comment = @submission.comments.build(:user_id => @current_user.id) if @current_user
    @comments = @submission.comments.all
  end

  def create
  	@submission = Submission.find(params[:submission_id])
  	@comment = @submission.comments.build(params[:comment])
  	@comment.user_id = @current_user.id
  	if @comment.save
  		flash[:success] = "Your comment has been posted"
  	else
  		flash[:error] = "There was a problem posting your comment"
  	end
  	redirect_to submission_comments_path(@submission)
  end

end