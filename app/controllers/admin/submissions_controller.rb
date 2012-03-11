class Admin::SubmissionsController < ApplicationController

  layout 'admin'

  def index
    @submissions = Submission.paginate(:page => params[:page]).order('created_at DESC').all
  end

  def edit
    @submission = Submission.find(params[:id])
  end

  def update
    @submission = Submission.find(params[:id])
    if @submission.update_attributes(params[:submission])
      flash[:success] = "The submission has been updated"
    else
      flash[:error] = "There was a problem deleting that submission"
    end
    redirect_to edit_admin_submission_path(@submission)
  end

  def confirm_delete
    @submission = Submission.find(params[:id])
  end

  def destroy
    @submission = Submission.find(params[:id])
    if @submission.destroy
      flash[:success] = "The submission has been deleted"
    else
      flash[:error] = "Opps, there was a problem deleting the submission"
    end
    redirect_to admin_submissions_path
  end

end