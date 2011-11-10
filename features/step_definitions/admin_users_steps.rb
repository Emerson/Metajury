Given /^I have a valid and confirmed admin user$/ do
  @user = Factory.create(:admin)
end

Given /^I login$/ do
  visit root_path
  fill_in 'email', :with => @user.email
  fill_in 'password', :with => 'password'
  click_button('login');
end