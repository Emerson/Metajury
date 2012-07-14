class Comment < ActiveRecord::Base

  has_ancestry

  belongs_to :submission
  belongs_to :user

  validates_presence_of :submission_id, :user_id, :content

end