Feature: Submissions
  In order for users to contribute content
  As a user
  I want to build a system that allows users to submit content and vote on it

Scenario: Adding a Submission
  Given I am a logged in user with the email "first-submitter@metajury.com" and the password "password"
  And I am on the new submission page
  And I add a new submission
  Then the submission appear in my submitted links page

Scenario: Logged in Homepage
  Given I am a logged in user with the email "logged-in-homepage@metajury.com" and the password "password"
  Then the root_path of metajury should be our user_homepage

@submission
Scenario: Logged out Homepage
  Given I am logged out and visit the homepage
  Then the root_path of metajury should be our homepage
