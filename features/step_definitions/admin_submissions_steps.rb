Given /^I visit the admin submissions page$/ do
  visit admin_submissions_path
  assert page.has_content?("Submissions")
end

Then /^I should see a list of submissions$/ do
  assert page.has_selector?("tr.submission")
end

Given /^I delete a submission$/ do
  link = page.find(:css, 'a.delete_admin_submission:last')
  @delete_submission_id = link['id'].split("_").last # returns id from delete_submission_#id
  link.click
  click_button('confirm_delete')
end

Then /^the submission should be deleted$/ do
  assert(Submission.where(:id => @delete_submission_id).first == nil)
end

Given /^I update a submission$/ do
  link = page.find(:css, 'a.edit_admin_submission_link:first')
  @update_submission_id = link['id'].split("_").last # returns id from delete_submission_#id
  link.click
  fill_in 'submission_title', :with => "A New Submission Title"
  click_button 'Update Submission'
end

Then /^the submission should be updated$/ do
  title = Submission.where(:id => @update_submission_id).first.title
  assert(title == "A New Submission Title", "#{Submission.where(:id => @update_submission_id).first.inspect}  Expecting: 'A New Submission Title', but have: #{title}")
end
