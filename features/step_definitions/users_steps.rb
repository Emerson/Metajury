Given /^I am a site visitor$/ do
  assert(true) # That's all we need
end

Given /^I have a valid and confirmed user$/ do
  @valid_confirmed = FactoryGirl.create(:user, :confirmed => true, :token => nil)
  assert (@valid_confirmed.valid? && @valid_confirmed.confirmed?)
end

Given /^I have an unconfirmed user$/ do
  @unconfirmed = FactoryGirl.create(:unconfirmed_user, :email => 'unconfirmed@example.com')
  assert !@unconfirmed.confirmed?
end

Given /^I am on the homepage$/ do
  visit root_path
  assert page.has_selector?('div.home')
end

Given /^I am logged out$/ do
  visit root_path
  assert page.has_selector?('form.login')
end

Then /^I should see "([^"]*)"$/ do |matcher|
  assert page.has_content?(matcher)
end

Given /^I login with the email "([^"]*)" and the password "([^"]*)"$/ do |email, password|
  user = FactoryGirl.create(:admin, :confirmed => true, :email => email, :password => password)
  fill_in 'email', :with => email
  fill_in 'password', :with => password
  click_button('login');
end

Then /^I should be logged in$/ do
  assert page.has_selector?('a.logout')
end

Given /^I am logged in$/ do
  user = FactoryGirl.create(:valid_user, :email => 'my-valid-user@example.com', :password => 'password')
  visit root_path
  fill_in 'email', :with => user.email
  fill_in 'password', :with => 'password'
  click_button('login')
end

Given /^then I log out$/ do
  click_link('logout')
end

Then /^I should be logged out$/ do
  assert page.has_selector?('form.login')
end

Given /^user signups are active$/ do
  assert ApplicationSettings.config['user_registration']
end

Given /^I am a logged in user with the email "([^"]*)" and the password "([^"]*)"$/ do |email, password|
  @current_user = FactoryGirl.create(:valid_user, :email => email, :password => password)
  visit root_path
  fill_in 'email', :with => email
  fill_in 'password', :with => password
  click_button('login')
end

Given /^I register with the email "([^"]*)" and the password "([^"]*)"$/ do |email, password|
  user = FactoryGirl.build(:valid_user, :email => email)
  visit signup_path
  fill_in 'user_email', :with => user.email
  fill_in 'user_password', :with => password
  fill_in 'user_username', :with => user.username
  click_button('signup')
  assert User.find_by_email(email)
end

Given /^I confirm "([^"]*)"'s account$/ do |email|
  user = User.find_by_email(email)
  visit confirmation_path(user.token)
  assert User.find_by_email(email).confirmed?
end

Given /^I login with "([^"]*)"'s account$/ do |email|
  user = User.find_by_email(email)
  visit root_path
  fill_in 'email', :with => user.email
  fill_in 'password', :with => 'password'
  click_button('login')
end

Given /^I have no user$/ do
  assert true
end

Given /^I login with "([^"]*)"$/ do |email|
  fill_in 'email', :with => email
  fill_in 'password', :with => 'password'
  click_button('login')
end

Then /^I should see an error message$/ do
  assert page.has_selector?('div.alert')
end

Given /^I try to login$/ do
  visit root_path
  fill_in 'email', :with => @unconfirmed.email
  fill_in 'password', :with => 'password'
  click_button('login')
end

Then /^I should see a "([^"]*)" button$/ do |arg1|
  assert page.has_selector?('.reconfirm')
end

Given /^I request a reconfirmation$/ do
  click_link('reconfirm')
end

Given /^I reconfirm my account$/ do
  unconfirmed = User.find_by_email(@unconfirmed.email)
  visit confirmation_path(unconfirmed.token)
  unconfirmed = User.find_by_email(@unconfirmed.email)
  assert unconfirmed.confirmed?
end

Then /^I should be valid and confirmed$/ do
  unconfirmed = User.find_by_email(@unconfirmed.email)
  assert unconfirmed.confirmed?
end

Given /^I update some account details$/ do
  visit account_path
  fill_in 'user_first_name', :with => 'Dr. Watson'
  click_button('update')
end

Then /^my account changes should be reflected$/ do
  assert page.find_field('user_first_name').value == 'Dr. Watson'
end

Given /^I try to update another persons account$/ do
  another_user = FactoryGirl.create(:valid_user, :email => 'another@user.comrake', :username => 'anotheruser')
  visit edit_user_path(another_user)
end

Then /^I should see an error$/ do
  assert page.has_selector?('.alert-error')
end

Given /^I have a user with the email "([^"]*)" and the password "([^"]*)"$/ do |email, password|
  FactoryGirl.create(:valid_user, :email => email, :password => password)
end

Given /^I try to login with the email "([^"]*)" and the password "([^"]*)"$/ do |email, password|
  visit login_path
  fill_in 'email', :with => email
  fill_in 'password', :with => password
  click_button('login')
end

Given /^I reset the "([^"]*)" account password to "([^"]*)"$/ do |email, new_password|
  user = User.find_by_email(email)
  visit request_password_reset_path
  fill_in 'password_request_email', :with => email
  click_button('request_reset_button')
  user = User.find_by_email(email)
  visit update_password_path(user.reset_token)
  fill_in 'new_password', :with => new_password
  click_button('update_password_button')
end

Then /^the "([^"]*)" account password should be "([^"]*)"$/ do |email, new_password|
  user = User.login(email, new_password)
  assert(user)
end