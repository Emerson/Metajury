Feature: Comments
  In order to engage the user base of metajury
  As a user
  I want to create a full-featured commenting system

Scenario: Adding a Comment
  Given I am a logged in user with the email "adding-commenter@metajury.com" and the password "password"
  And there is a valid submission
  And I am on the homepage
  And I add a comment
  Then the submission should have a comment

Scenario: Comments Page
  Given I am a site visitor
  And there is a valid submission with "5" comments
  And I am on the homepage
  And I click on the first comments link
  Then I should see a list of comments

Scenario: Logged Out Users Cannot Comment
  Given I am a site visitor
  And there is a valid submission with "5" comments
  And I am on the homepage
  And I click on the first comments link
  Then I should not see the add comment textarea

Scenario: Submissions should have a comment count
  Given I am a site visitor
  And there is a valid submission with "5" comments
  And I am on the homepage
  Then I should see a comment link with "5" comments