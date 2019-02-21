@dev
Feature: Stanford Conference
  In order to ensure that the stanford_conference_administration module is installed and functional
  As an administrative user
  I want to ensure that the Stanford Conference Administration module is working properly

  Background:
    And I am logged in as a user with the "administrator" role

  @api @safe
  Scenario: Check the conference administration view is there.
    And I am on "admin/manage/conferences"
    Then I should see "Manage All Content"
