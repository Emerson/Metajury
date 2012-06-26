require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "validity" do
    comment = FactoryGirl.create(:valid_comment)
    assert comment.valid?
  end

end
