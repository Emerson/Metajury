Given /^I add a submission with the tag "([^"]*)"$/ do |name|
  visit new_submission_path
  fill_in 'submission_url', :with => 'http://www.example.com'
  fill_in 'submission_title', :with => 'Example Title'
  fill_in 'submission_description', :with => 'This is an example description'
  fill_in 'tags_list', :with => name
  click_button 'Add Submission'
end

Then /^the "([^"]*)" tag should contain one submission$/ do |name|
  tag = Tag.find_by_name(name)
  assert(tag.instance_of?(Tag), "Tag not found: #{Tag.all.inspect}")
  assert(tag.submissions.count == 1, "Expecting 1, but got #{tag.submissions.count}")
end

Given /^I visit the "([^"]*)" path$/ do |name|
  tag = Tag.find_by_name(name)
  visit tag_path(tag.slug)
end

Then /^i should see a submission$/ do
  save_and_open_page
end