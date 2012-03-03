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

end