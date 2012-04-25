Given /^I add a submission with the tag "([^"]*)"$/ do |name|
  visit new_submission_path
  fill_in 'submission_url', :with => 'http://www.example.com'
  fill_in 'submission_title', :with => 'Example Title'
  fill_in 'submission_description', :with => 'This is an example description'
  page.execute_script("$('#tags_list').select2('val', {id: '#{name}', name: '#{name}'});")
  click_button 'Add Submission'
  sleep(1) # removing this results in failed tests
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
  assert(page.has_selector?(".alert-error") === false, "Error flash message on page")
  assert(page.has_selector?(".submission-information"))
end

Given /^there is a valid submission with the tag "([^"]*)"$/ do |name|
  tag = Tag.create(:name => name)
  submission = Factory.create(:valid_submission)
  submission.tags << tag
  assert(submission.tags.count === 1, "Expecting 1, but got #{submission.tags.count}")
end