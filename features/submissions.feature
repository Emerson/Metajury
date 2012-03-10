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

Scenario: Logged out Homepage
  Given I am logged out and visit the homepage
  Then the root_path of metajury should be our homepage

Scenario: Up vote a submission
  Given I am a logged in user with the email "logged-in-upvoter@metajury.com" and the password "password"
  And there is a valid submission
  And I am on the homepage
  And I upvote a valid submission
  Then the submission should receive a vote

Scenario: Down vote a submission
  Given I am a logged in user with the email "logged-in-downvoter@metajury.com" and the password "password"
  And there is a valid submission
  And I am on the homepage
  And I downvote a valid submission
  Then the submission should lose a vote

Scenario: Users cannot double upvote
  Given I am a logged in user with the email "double-upvoter@metajury.com" and the password "password"
  And there is a valid submission
  And I am on the homepage
  And I upvote a valid submission twice
  Then I should see an error message about already voting

Scenario: Users can remove an upvote
  Given I am a logged in user with the email "flipflopper@metajury.com" and the password "password"
  And there is a valid submission
  And I am on the homepage
  And I upvote and then downvote a submission
  Then my vote should be removed from the submission