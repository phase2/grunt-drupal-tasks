@api
Feature: Stanford large block bean Type
  In order to ensure that the large block bean exists
  As an administrator
  I want to check that the Stanford large block bean types module is working correctly

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe
  Scenario: Stanford large block type exists
    And I am on "block/add"
    Then I should see the link "stanford_large_block" in the "Content" region

  @safe
  Scenario: Stanford Large Block Type Fields Exist
    Given I am on "admin/structure/block-types/manage/stanford-large-block/fields"
    Then I should see "Label"
    Then I should see "Title"
    Then I should see "field_s_large_block_body"
    Then I should see "field_s_large_block_image_insert"
    Then I should see "field_s_large_block_file_insert"
    Then I should see "field_s_large_blk_read_more_link"
    Then I should see "view_mode"

  @safe
  Scenario: Stanford Large Block Type Display Modes
    Given I am on "admin/structure/block-types/manage/stanford-large-block/display"
    Then I should see "Body"
    Then I should see "Read More Link"
    Then I want to validate select field option "fields[field_s_large_block_file_insert][parent]" default is "- None -"
    Then I want to validate select field option "fields[field_s_large_block_image_insert][parent]" default is "- None -"

  @dev @destructive
  Scenario: Create large block
    And I am on "block/add/stanford-large-block"
    Then I fill in "edit-label" with "Behat Large Block"
    Then I fill in "edit-title" with "Behat large Block"
    Then I fill in "field_s_large_block_body[und][0][value]" with "This is the body content"
    Then I attach the file "features/stanford_bean_types/img/ooooaaaahhh.jpg" to "files[field_s_large_block_image_insert_und_0]"
    Then I fill in "field_s_large_blk_read_more_link[und][0][title]" with "This is the read more link title"
    Then I fill in "field_s_large_blk_read_more_link[und][0][url]" with "http://www.stanford.edu"
    Then I press "Save"
    Then I should see "Behat Large Block"
    Then I should see 1 ".field-name-field-s-large-blk-read-more-link" element
    Then I should see "This is the body content"
    Then I click "Delete Block"
    Then I press "Delete"
    Then I should see "stanford_large_block Behat Large Block has been deleted."
