class Comment < ActiveRecord::Base

  has_ancestry

  belongs_to :submission
  belongs_to :user
  has_many :votes, :foreign_key => :item_id, :dependent => :destroy

  validates_presence_of :submission_id, :user_id, :content

  def update_rank
  end

  def tally
    self.total_up_votes - self.total_down_votes
  end

  # total_votes
  # ===========
  # Returns a fresh tally of total votes
  def total_votes
    self.reload
    self.votes.count
  end

  # total_up_votes
  # ==============
  # Returns a count of up votes
  def total_up_votes
    self.reload
    self.votes.are(:up).count
  end

  # total_down_votes
  # ================
  # Returns a count of down votes
  def total_down_votes
    self.reload
    self.votes.are(:down).count
  end

end