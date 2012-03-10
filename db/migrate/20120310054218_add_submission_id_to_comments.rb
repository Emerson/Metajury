class AddSubmissionIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :submission_id, :integer

  end
end
