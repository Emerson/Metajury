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