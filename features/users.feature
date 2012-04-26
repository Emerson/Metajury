Feature: Users
  In order to user the other features of the application
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
  And I login with the email "confirmed-user@cucumber.com" and the password "password"
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

Scenario: Unconfirmed User
  Given I have an unconfirmed user
  And I try to login
  Then I should see a "resend confirmation" button

Scenario: Reconfirmation Flow
  Given I have an unconfirmed user
  And I try to login
  And I request a reconfirmation
  And I reconfirm my account
  Then I should be valid and confirmed

Scenario: Account Update
  Given I have a valid and confirmed user
  And I am logged in
  And I update some account details
  Then my account changes should be reflected

Scenario: Only Edit Personal Account
  Given I have a valid and confirmed user
  And I am logged in
  And I try to update another persons account
  Then I should see an error
  
Scenario: Password Reset Flow
  Given I have a user with the email "password-reset@rocketfuel.com" and the password "password"
  And I try to login with the email "password-reset@rocketfuel.com" and the password "wrongpassword"
  And I reset the "password-reset@rocketfuel.com" account password to "newpassword"
  Then the "password-reset@rocketfuel.com" account password should be "newpassword"

@view
Scenario: Viewing User Submissions Page
  Given I have a user with the email "mysubmissions@rocketfuel.com" and the password "password"
  And the user "mysubmissions@rocketfuel.com" has 5 submissions
  And I am logged out
  And I visit the submission page for "mysubmissions@rocketfuel.com"
  Then I should see 5 submissions  