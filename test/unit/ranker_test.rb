require 'test_helper'

class RankerTest < ActiveSupport::TestCase

  test "Submission.recalculate_ranks should recalculate rankings" do
    submission = Factory.create(:valid_submission)
    previous_score = submission.score
    # Add 100 votes
    (0..100).each_with_index do |vote, index|
      Vote.create(:item_id => submission.id, :user_id => index + 1, :vote_type => 'up')
    end    
    Submission.recalculate_ranks
    submission.reload
    assert(submission.score != previous_score, "Score - Before: #{previous_score}, After: #{submission.score}")
  end

  test "A submission should have a score when created" do
    submission = Factory.create(:valid_submission)
    assert(!submission.score != nil)
  end

end