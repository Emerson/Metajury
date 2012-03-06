require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase

  test "A valid submission should be valid" do
    submission = Factory.create(:valid_submission)
    assert submission.valid?
  end

  test "Submissions should belong to a user" do
    user = Factory.create(:valid_user)
    submission = user.submissions.create({:user_id => user.id})
    assert(user.id === submission.user_id)
  end

  test "Submissions should have many votes" do
    submission = Factory.create(:valid_submission)
    vote = submission.votes.build(:user_id => 1)
    assert(vote, "The vote was: #{vote}")
  end

  test "user.submission.vote(:type, submission_object) should add a vote with the passed type" do
    user = Factory.create(:valid_user, :id => 1535353153)
    submission = Factory.create(:valid_submission)
    vote = user.vote(:up, submission)
  end

  test "user.submission.vote(:type, submission_object) should return false if a user double votes" do
    user = Factory.create(:valid_user, :id => 5530873153)
    submission = Factory.create(:valid_submission)
    vote = user.vote(:up, submission)
    assert(!user.vote(:up, submission))
  end

  test "self.total_votes should return fresh vote count" do
    # Add thirty up votes to a submission
    submission = Factory.create(:valid_submission, :id => 7401482)
    counter = 0
    (10..40).each do |i|
      user = Factory.create(:valid_user, :email => "totalvoter-#{i}@metajury.com")
      counter = counter + 1
      user.vote(:up, submission)
    end
    assert(submission.total_votes === counter, "Votes: #{submission.total_votes}, should be #{counter}")
  end

  test "self.up_votes should return a fresh 'up' vote count" do
    # Add thirty up votes to a submission
    submission = Factory.create(:valid_submission)
    counter = 0
    (10..40).each do |i|
      user = Factory.create(:valid_user, :email => "upvoter-#{i}@metajury.com")
      counter = counter + 1
      user.vote(:up, submission)
    end
    assert(submission.total_up_votes === counter, "Votes: #{submission.total_votes.inspect}, should be #{counter}")
  end

  test "self.down_votes should return a fresh 'down' vote count" do
    # Add thirty down votes to a submission
    submission = Factory.create(:valid_submission)
    counter = 0
    (10..40).each do |i|
      user = Factory.create(:valid_user, :email => "downvoter-#{i}@metajury.com")
      counter = counter + 1
      user.vote(:down, submission)
    end
    assert(submission.total_down_votes === counter, "Votes: #{submission.total_votes.inspect}, should be #{counter}")
  end

  test "destroying a submission should destroy any associated votes" do
    submission = Factory.create(:valid_submission)
    vote = Vote.create(:item_id => submission.id, :user_id => 1)
    submission.destroy
    assert(Vote.where(:item_id => submission.id).all.count === 0, "Associated vote was not destroyed")
  end

  test "user.voted?(:type, submission) should return true if a user has already voted" do
    submission = Factory.create(:valid_submission)
    user = Factory.create(:valid_user)
    user.vote(:up, submission)
    assert(user.voted?(:up, submission))
  end

  test "user.friendly_url should return a url without the path" do
    submission = Factory.create(:valid_submission, :url => 'http://www.example.com/example?i=13531')
    assert(submission.friendly_url === 'http://www.example.com', "Output was: #{submission.friendly_url}")
  end

end