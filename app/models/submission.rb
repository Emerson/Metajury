class Submission < ActiveRecord::Base

  # Validations
  validates_presence_of :title, :description, :url, :user_id

  # Associations
  belongs_to :user
  has_many :votes, :foreign_key => :item_id, :dependent => :destroy

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
    self.votes.are(:up).count
  end

  # total_down_votes
  # ================
  # Returns a count of down votes
  def total_down_votes
    self.votes.are(:down).count
  end

end
