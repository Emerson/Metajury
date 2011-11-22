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
  @edited_user = Factory.create(:user, :email => 'user_to_edit@editing.com')
  visit admin_users_path
  assert page.has_selector?('table.admin_users')
end

Given /^I choose to edit a user and update their account$/ do
  link = page.find(:css, 'a.edit_admin_user_link')
  @edit_id = link['id'].split("_").last # returns id from user_13
  link.click
  @new_name = "Jerry"
  fill_in 'user_first_name', :with => @new_name
  click_button('Update User')
end

Then /^their profile should be updated$/ do
  edited_user = User.find_by_id(@edit_id)
  assert_equal(@new_name, edited_user.first_name)
end

Given /^there are some users$/ do
  (1..10).each do |i|
    Factory.create(:valid_user, :email => "clone+#{i}@rocketfuel.com")
  end
  assert(User.all.count > 9)
end

Given /^I delete one$/ do
  Factory.create(:valid_user, :email => 'deleted@rocketfuel.com')
  visit admin_users_path
  link = page.find(:css, 'a.delete_admin_user:last')
  @delete_id = link['id'].split("_").last # returns id from delete_user_13
  link.click
  click_button('confirm_delete')
end

Then /^their account should be removed$/ do
  assert_nil(User.find_by_id(@delete_id))
end


