@api
Feature: Stanford icon_block bean Type
  In order to ensure that the icon_block bean exists
  As an administrator
  I want to check that the Stanford icon_block bean types module is working correctly

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe
  Scenario: Stanford icon_block type exists
    And I am on "block/add"
    Then I should see the link "stanford_icon_block" in the "Content" region

  @safe
  Scenario: Stanford Icon Block Type Fields Exist
    Given I am on "admin/structure/block-types/manage/stanford-icon-block/fields"
    Then I should see "Label"
    Then I should see "Title"
    Then I should see "field_s_icon_icon"
    Then I should see "field_s_icon_body"
    Then I should see "field_s_icon_link"
    Then I should see "view_mode"

  @safe
  Scenario: Stanford Icon Block Type Display Modes
    Given I am on "admin/structure/block-types/manage/stanford-icon-block/display"
    Then I should see "Postcard"
    Then I should see "group_postcard"
    Then I should see "Postcard Icon"
    Then I should see "group_postcard_icon"
    Then I should see "Icon"
    Then I should see "Postcard Content"
    Then I should see "Title"
    Then I should see "Body"
    Then I should see "Read More Link"
    Then I should see "group-postcard-icon field-group-div"
    Then I should see "postcard-content"
    Then I want to validate select field option "fields[field_s_icon_link][type]" default is "Title, as link (default)"

  @dev @destructive
  Scenario: Create Icon block
    And I am on "block/add/stanford-icon-block"
    Then I fill in "Label" with "BeHat Test Icon Block"
    Then I fill in "Title" with "BeHat Test Icon Block"
    Then I select "Apple" from "Icon"
    Then I fill in "field_s_icon_body[und][0][value]" with "This is the body content"
    Then I fill in "field_s_icon_link[und][0][title]" with "This is the more link"
    Then I fill in "field_s_icon_link[und][0][url]" with "http://www.stanford.edu"
    Then I press "Save"
    Then I should see the message "stanford_icon_block BeHat Test Icon Block has been created"
    Then I should see "This is the body content"
    Then I should see 1 ".icon-apple" element
    Then I should see "BeHat Test Icon Block"
    Then I should see "This is the more link"
    Then I click "Delete Block"
    Then I press "Delete"
    Then I should see "stanford_icon_block BeHat Test Icon Block has been deleted."

