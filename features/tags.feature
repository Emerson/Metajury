Feature: Submissions
  In order to better organize content
  As a site user
  I want to allow users to tag submissions


Scenario: Tag a Submission
  Given I have a valid and confirmed user
  And I am logged in
  And I add a submission with the tag "Example"
  Then the "Example" tag should contain one submission

@tag
Scenario: Viewing Submissions by Tag
  Given I have a valid and confirmed user
  And I am logged in
  And I add a submission with the tag "View By Tag"
  And I visit the "View By Tag" path
  Then i should see a submission
