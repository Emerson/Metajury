Feature: Admin Submissions
  In order to manage user submissions
  As an admin user
  I want to be able to add, edit, delete, and moderate submissions

Scenario: View Submissions
  Given I am logged in as an admin user
  And there are "5" submissions
  And I visit the admin submissions page
  Then I should see a list of submissions

Scenario: Deleting a Submission
  Given I am logged in as an admin user
  And there are "5" submissions
  And I visit the admin submissions page
  And I delete a submission
  Then the submission should be deleted

@update_submission
Scenario: Update Submission
  Given I am logged in as an admin user
  And there are "5" submissions
  And I visit the admin submissions page
  And I update a submission
  Then the submission should be updated