Feature: Admin Users
  In order to manage the other users of the application
  As an admin user
  I want to be able to add, edit, and delete user accounts

Scenario: Admin Layout
  Given I have a valid and confirmed admin user
  And I am on the homepage
  And I login
  Then I should see the admin layout