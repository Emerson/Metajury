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

  # total_abstain_votes
  # ===================
  # Returns a count of abstained votes
  def total_abstain_votes
    self.votes.are(:abstain).count
  end

  # friendly_url
  # ============
  # Returns a friendly URL from a URL with a long path
  def friendly_url
    uri = URI(url)
    uri.scheme + "://" + uri.host
  end

end
