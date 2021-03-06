Feature: Admin Users
  In order to manage the other users of the application
  As an admin user
  I want to be able to add, edit, and delete user accounts

Scenario: Admin Layout
  Given I have a valid and confirmed admin user
  And I am on the homepage
  And I login
  Then I should see the admin layout

Scenario: Admin Menu
  Given I am logged in as an admin user
  And I am on the homepage
  Then I should see the admin menu

Scenario: Admin Add Users
  Given I am logged in as an admin user
  And I am on the new user page
  Then I should be able to add new users

Scenario: Admin Dashboard
  Given I am logged in as an admin user
  Then I should see the dashboard page

Scenario: Admin Add User Menu
  Given I am logged in as an admin user
  And I am on the new user page
  Then I should special admin fields

Scenario: Admin Edit User Flow
  Given I am logged in as an admin user
  And I am on the admin users page
  And I choose to edit a user and update their account
  Then their profile should be updated

Scenario: Admin Delete User Flow
  Given I am logged in as an admin user
  And there are some users
  And I delete one
  Then their account should be removed