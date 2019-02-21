Feature: Stanford Magazine Issue
  In order to ensure the fields for the Stanford Magazine Issue are correct.
  As an administrator

  @safe @api
  Scenario: Verify fields for the Stanford Magazine Issue exist as expected
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/types/manage/stanford_magazine_issue/fields"
    And I should see "body"
    And I should see "field_s_mag_issue_article_2"
    And I should see "field_s_mag_issue_article_3"
    And I should see "field_s_mag_issue_article_4"
    And I should see "field_s_mag_issue_article_5"
    And I should see "field_s_mag_issue_featured"
    And I should see "field_s_mag_issue_number"

    Then I am on "admin/structure/types/manage/stanford_magazine_issue/display/default"
    And I want to validate select field option "fields[body][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_article_2][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_article_3][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_article_4][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_article_5][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_featured][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_number][region]" default value is "hidden"

    Then I am on "admin/structure/types/manage/stanford_magazine_issue/display/teaser"
    And I want to validate select field option "fields[body][type]" default value is "text_summary_or_trimmed"
    And I want to validate select field option "fields[field_s_mag_issue_article_2][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_article_3][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_article_4][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_article_5][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_featured][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_issue_number][type]" default value is "hidden"

