class SubmissionsController < ApplicationController

  before_filter :require_logged_in_user, :except => [:index, :tag, :user_submissions]

  def index
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = @current_user.submissions.build(params[:submission])
    if @submission.save
      unless params[:tags][:list].blank?
        tags = Tag.from_list(params[:tags][:list])
        @submission.tags << tags unless tags.blank?
      end
      flash[:success] = "Your submission has been added"
      redirect_to root_path
    else
      flash[:error] = "There was a problem adding your submission"
      render :new
    end
  end

  def user_submissions
    @user = User.find(params[:id])
    @submissions = @user.submissions.paginate(:page => params[:page]).order('created_at DESC').all
  end

  def current_user_submissions
    @submissions = @current_user.submissions.paginate(:page => params[:page]).order('created_at DESC').all
  end

  def view
  end

  def tag
    @tag = Tag.find_by_slug(params[:tag])
    @submissions = @tag.submissions.paginate(:page => params[:page]).order('score DESC, created_at DESC')
  end

  def tag_list
    slug = Tag.new(:name => params[:q]).normalize_friendly_id(params[:q])
    @tags = Tag.where("name LIKE ?", "%#{slug}%").all
    render :json => @tags
  end

  def destroy
  end

  def upvote
    session[:return_to] ||= request.referer
    @submission = Submission.find(params[:id])
    if @current_user.vote(:up, @submission)
      flash[:success] = "You have upvoted a story"
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
      flash[:success] = "You have downvoted a story"
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