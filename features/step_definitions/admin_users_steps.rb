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
