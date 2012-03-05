Given /^I am on the new submission page$/ do
  visit new_submission_path
  assert page.has_selector?('form#new_submission')
end

Given /^I add a new submission$/ do
  fill_in 'submission_url', :with => 'http://www.metajury.com'
  fill_in 'submission_title', :with => 'Cool new site'
  fill_in 'submission_description', :with => 'Another new site that allows you to submit and vote on links'
  click_button 'Add Submission'
end

Then /^the submission appear in my submitted links page$/ do
  visit user_submissions_path
  assert page.has_content?('Cool new site')
end

Then /^the root_path of metajury should be our user_homepage$/ do
  visit root_path
  assert page.has_selector?("[data-homepage='logged-in']")
end

Given /^I am logged out and visit the homepage$/ do
  visit logout_path
  visit root_path
end

Then /^the root_path of metajury should be our homepage$/ do
  assert page.has_selector?("[data-homepage='logged-out']")
end

Given /^there is a valid submission$/ do
  Factory.create(:valid_submission)
end

Given /^I upvote a valid submission$/ do
  visit root_path
  @upvoted_submission_id = page.find('.submission:first')['data-submission-id']
  @upvoted_previous_up_votes = page.find('.submission:first')['data-submission-upvotes']
  click_link("submission-#{@upvoted_submission_id}-upvote")
end

Then /^the submission should receive a vote$/ do
  submission = Submission.find(@upvoted_submission_id)
  assert(submission.total_up_votes === (@upvoted_previous_up_votes.to_i + 1))
end

Given /^I downvote a valid submission$/ do
  visit root_path
  @downvoted_submission_id = page.find('.submission:first')['data-submission-id']
  @downvoted_previous_down_votes = page.find('.submission:first')['data-submission-downvotes']
  click_link("submission-#{@downvoted_submission_id}-downvote")
end

Then /^the submission should lose a vote$/ do
  submission = Submission.find(@downvoted_submission_id)
  assert(submission.total_down_votes === (@downvoted_previous_down_votes.to_i + 1))
end

Given /^I upvote a valid submission twice$/ do
  @double_vote_id = page.find('.submission:first')['data-submission-id']
  click_link("submission-#{@double_vote_id}-upvote")
  visit root_path
  click_link("submission-#{@double_vote_id}-upvote")
end

Then /^I should see an error message about already voting$/ do
  assert page.has_content?('only upvote a submission once')
end