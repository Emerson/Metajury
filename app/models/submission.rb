class Submission < ActiveRecord::Base

  include Ranker

  # Validations
  validates_presence_of :title, :description, :url, :user_id

  # Associations
  belongs_to :user
  has_many :votes, :foreign_key => :item_id, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  # Callbacks
  after_create :add_initial_upvate

  self.per_page = 50

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

  # update_rank
  # ===========
  # Updates the rank of a submission
  def update_rank
    self.score = calculate_score
    self.save
  end

  # add_initial_upvate
  # ==================
  # Adds an initial upvote to a submission by it's creator
  def add_initial_upvate
    Vote.create(:item_id => self.id, :user_id => self.user_id, :vote_type => 'up')
    self.update_rank
  end

  # Class Methods


  # recalculate_ranks
  # =================
  # Loops through all records and recalculates their ranks
  def self.recalculate_ranks
    self.all.each do |submission|
      submission.update_rank
    end
  end

end
