Given /^I have a valid and confirmed user$/ do
  user = Factory.create(:user, :confirmed => true, :token => nil)
  assert (user.valid? && user.confirmed?)
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
  user = Factory.create(:admin, :confirmed => true, :email => email, :password => password)
  fill_in 'email', :with => email
  fill_in 'password', :with => password
  click_button('login');
end

Then /^I should be logged in$/ do
  assert page.has_selector?('a.logout')
end

Given /^I am logged in$/ do
  user = Factory.create(:valid_user, :email => 'my-valid-user@example.com', :password => 'password')
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

Given /^I register with the email "([^"]*)" and the password "([^"]*)"$/ do |email, password|
  user = Factory.build(:valid_user, :email => email)
  visit signup_path
  fill_in 'user_email', :with => user.email
  fill_in 'user_password', :with => password
  fill_in 'user_first_name', :with => user.first_name
  fill_in 'user_last_name', :with => user.last_name
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


Given /^I have an unconfirmed user$/ do
  user = Factory.create(:unconfirmed_user, :email => 'unconfirmed@example.com')
end

Given /^I try to login$/ do
  visit root_path
  fill_in 'email', :with => 'unconfirmed@example.com'
  fill_in 'password', :with => 'password'
  click_button('login')
end

Then /^I should see a "([^"]*)" button$/ do |arg1|
  assert page.has_selector?('.reconfirm')
end

