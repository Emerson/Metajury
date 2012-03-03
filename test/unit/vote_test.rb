require "test_helper"

class VoteTest < ActiveSupport::TestCase

	test "A user should be able to create a vote" do
		user = Factory.create(:valid_user)
		assert user.votes.create(Factory.attributes_for(:vote, :item_id => 1))
	end

	test "A user should only be able to vote on an item once" do
		user = Factory.create(:valid_user)
		first_vote = user.votes.create(:item_id => 1)
		second_vote = user.votes.build(:item_id => 1)
		assert(!second_vote.valid?, "First vote was: #{first_vote.inspect}\nSecond vote was: #{second_vote.inspect}")
	end

end