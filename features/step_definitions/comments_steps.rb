Given /^I add a comment$/ do
  link = page.find('.comments_link:first')
  link.click
  comment = FactoryGirl.create(:valid_comment)
  fill_in 'comment_content', :with => comment.content
  click_button 'add_comment'
end

Then /^the submission should have a comment$/ do
  assert(page.has_css?('div.comment'))
end

Given /^there is a valid submission with "([^"]*)" comments$/ do |number_of_comments|
  submission = FactoryGirl.create(:valid_submission)
  user = FactoryGirl.create(:valid_user)
  (1..number_of_comments.to_i).each do |i|
    comment = FactoryGirl.create(:valid_comment, :submission_id => submission.id, :user_id => user.id)
  end
  submission.reload
  assert(submission.comments.count == 5, "There are only #{submission.comments.count} comments")
end

Given /^I click on the first comments link$/ do
  link = page.find(:css, '.comments_link')
  link.click
end

Then /^I should see a list of comments$/ do
  assert(page.has_css?('div.comment', :count => 5))
end

Then /^I should not see the add comment textarea$/ do
  assert(!page.has_css?('form#new_comment'))
end

Then /^I should see a comment link with "([^"]*)" comments$/ do |count|
  number_of_comments = page.find(:css, 'a.comments_link:first')['data-number-of-comments']
  assert(number_of_comments.to_i == count.to_i, "Expected #{count} comments, only found #{number_of_comments}")
end
