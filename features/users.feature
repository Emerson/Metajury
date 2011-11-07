Feature: Users
  In order to user the other features of the staff portal
  As a user
  I want to create a full-featured user system

Scenario: Logged Out User
  Given I have a valid and confirmed user
  And I am on the homepage
  And I am logged out
  Then I should see "login"

Scenario: User Login Flow
  Given I have a valid and confirmed user
  And I am on the homepage
  And I am logged out
  And I login with the email "emerson.lackey@gmail.com" and the password "password"
  Then I should be logged in

Scenario: User Logout Flow
  Given I am logged in
  And then I log out
  Then I should be logged out

Scenario: User Signup Flow
  Given user signups are active
  And I am on the homepage
  And I register with the email "user-signup@cucumber.com" and the password "password"
  And I confirm "user-signup@cucumber.com"'s account
  And I login with "user-signup@cucumber.com"'s account
  Then I should be logged in

Scenario: Invalid User Login
  Given I have no user
  And I am on the homepage
  And I login with "bad-user@cucumber.com"
  Then I should see an error message
  