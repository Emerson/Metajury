require 'test_helper'

class TagTest < ActiveSupport::TestCase
  
  test "Tag.from_list should find or create tags from a comma seperated list and submission id" do
    submission = FactoryGirl.create(:valid_submission)
    tags = Tag.from_list("From List 1, From List 2, From List 3")
    submission.tags << tags
    assert(Tag.all.count === 3, "Should have 3 tags but counted #{Tag.all.count}")
  end

  test "Tags should have a unique slug" do
    tag = Tag.new(:name => 'I have a slug')
    tag.save
    assert(tag.slug == 'i-have-a-slug', "Slug was empty of did not match")

    tag = Tag.new(:name => 'I have a slug')
    assert(tag.slug != 'i-have-a-slug', "Duplicate slug detected")
  end

  test "Tags should be associated to a submission" do
    submission = FactoryGirl.create(:valid_submission)
    tag = Tag.new(:name => 'Awesome Tag')
    tag.save

    submission.tags << tag
    s = Submission.find(submission.id)
    assert(s.tags.count == 1, "#{s.tags.inspect}")
    assert(s.tags.first.id == submission.id, "#{s.tags.inspect}")
  end

end