@api
Feature: Stanford big_text_block bean Type
  In order to ensure that the big_text_block bean exists
  As an administrator
  I want to check that the Stanford big_text_block bean types module is working correctly

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe
  Scenario: Stanford Big Text Block Type Exists
    Given I am on "block/add"
    Then I should see the link "stanford_big_text_block" in the "Content" region

  @safe
  Scenario: Stanford Big Text Block Type Fields Exist
    Given I am on "admin/structure/block-types/manage/stanford-big-text-block/fields"
    Then I should see "Label"
    Then I should see "Title"
    Then I should see "field_s_big_text_block_lead_text"
    Then I should see "field_s_big_text_block_body"
    Then I should see "field_s_big_text_block_more_link"
    Then I should see "view_mode"

  @safe
  Scenario: Stanford Big Text Block Type Display Modes
    Given I am on "admin/structure/block-types/manage/stanford-big-text-block/display"
    Then I should see "Big Text"
    Then I should see "group_s_big_text_style"
    Then I should see "Lead Text"
    Then I should see "body"
    # Group label
    Then I should see "More Link"
    Then I should see "group_s_more_link"
    # Field label
    Then I should see "More link"
    Then I want to validate select field option "fields[field_s_big_text_block_more_link][type]" default is "Title, as link (default)"

  @dev @destructive
  Scenario: Create stanford banner block
    And I am on "block/add/stanford-big-text-block"
    Then I fill in "edit-label" with "Behat Big Text Block"
    Then I fill in "edit-title" with "Behat Big Text Block"
    Then I fill in "field_s_big_text_block_lead_text[und][0][value]" with "This is the lead text"
    Then I fill in "field_s_big_text_block_body[und][0][value]" with "This is in the body"
    Then I fill in "field_s_big_text_block_more_link[und][0][title]" with "The link title is this"
    Then I fill in "field_s_big_text_block_more_link[und][0][url]" with "http://www.stanford.edu"
    Then I press "Save"
    Then I should see "stanford_big_text_block Behat Big Text Block has been created."
    Then I should see "This is the lead text"
    Then I should see "This is in the body"
    Then I should see 1 ".field-name-field-s-big-text-block-more-link" element
    Then I click "Delete Block"
    Then I press "Delete"
    Then I should see "stanford_big_text_block Behat Big Text Block has been deleted."
