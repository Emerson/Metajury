class Comment < ActiveRecord::Base

  has_ancestry

  belongs_to :submission
  belongs_to :user
  has_many :votes, :foreign_key => :item_id, :dependent => :destroy

  validates_presence_of :submission_id, :user_id, :content

  def update_rank
  end

end