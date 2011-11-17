Given /^I have a valid and confirmed admin user$/ do
  @user = Factory.create(:admin)
end

Given /^I login$/ do
  visit root_path
  fill_in 'email', :with => @user.email
  fill_in 'password', :with => 'password'
  click_button('login')
end

Then /^I should see the admin layout$/ do
  assert page.has_selector?('body.admin'), "Body missing the admin class"
end

Given /^I am logged in as an admin user$/ do
  user = Factory.create(:admin)
  visit root_path
  fill_in 'email', :with => user.email
  fill_in 'password', :with => 'password'
  click_button('login')
end

Then /^I should see the admin menu$/ do
  visit admin_root_path
  assert page.has_selector?('ul.nav li.users')
end

Then /^I should see the dashboard page$/ do
  assert page.has_selector?('div.dashboard')
end

Given /^I am on the new user page$/ do
  visit admin_users_path
  click_link('new_admin_user')
end

Then /^I should be able to add new users$/ do
  user = Factory.build(:user, :email => 'added-by-admin@test.com')
  fill_in 'user_email', :with => user.email
  fill_in 'user_password', :with => 'password'
  fill_in 'user_first_name', :with => user.first_name
  fill_in 'user_last_name', :with => user.last_name
  click_button('Add User')
  assert User.find_by_email(user.email)
end

Then /^I should special admin fields$/ do
  assert page.has_selector?('#user_send_password')
  assert page.has_selector?('#user_user_level')
end

Given /^I am on the admin users page$/ do
  edited_user = Factory.create(:user, :email => 'user_to_edit@editing.com')
  visit admin_users_path
  assert page.has_selector?('table.admin_users')
end

Given /^I choose to edit a user$/ do
  click_link('a.edit_admin_user_link:last')
end

Given /^I update their profile information$/ do
  save_and_open_page
  pending # express the regexp above with the code you wish you had
end

Then /^their profile should be updated$/ do
  pending # express the regexp above with the code you wish you had
end
