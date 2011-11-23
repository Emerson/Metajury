require 'test_helper'

class FeedTest < ActiveSupport::TestCase

  test "Feed.new_user(@user) should return a properly formatted feed entry" do
    user = Factory.create(:valid_user)
    entry = Feed.new_user(user)
    assert( !entry.user_id.blank? && entry.admin == true && entry.public_feed == false && !entry.data.blank? && entry.feed_type == 'user_registration' )
  end

  test "Feed.confirm_user(@user) should return a properly formatted feed entry" do
    user = Factory.create(:valid_user)
    entry = Feed.confirm_user(user)
    assert( !entry.user_id.blank? && entry.admin == true && entry.public_feed == false && !entry.data.blank? && entry.feed_type == 'user_confirmation' )
  end

  test "Feed.login_user(@user) should return a properly formatted feed entry" do
    user = Factory.create(:valid_user)
    entry = Feed.login_user(user)
    assert( !entry.user_id.blank? && entry.admin == true && entry.public_feed == false && !entry.data.blank? && entry.feed_type == 'user_login' )
  end

  test "Feed.logout_user(@user) should return a properly formatted feed entry" do
    user = Factory.create(:valid_user)
    entry = Feed.logout_user(user)
    assert( !entry.user_id.blank? && entry.admin == true && entry.public_feed == false && !entry.data.blank? && entry.feed_type == 'user_logout' )
  end

end