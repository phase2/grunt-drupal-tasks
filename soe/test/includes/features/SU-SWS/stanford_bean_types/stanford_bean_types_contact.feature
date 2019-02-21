@api
Feature: Stanford contact bean Type
  In order to ensure that the contact bean exists
  As an administrator
  I want to check that the Stanford contact bean types module is working correctly

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe
  Scenario: Stanford contact type exists
    And I am on "block/add"
    Then I should see the link "stanford_contact" in the "Content" region

  @safe
  Scenario: Stanford Contact Block Type Fields Exist
    Given I am on "admin/structure/block-types/manage/stanford-contact/fields"
    Then I should see "Label"
    Then I should see "Title"
    Then I should see "field_s_contact_address_line_1"
    Then I should see "field_s_contact_address_line_2"
    Then I should see "field_s_contact_address_line_3"
    Then I should see "field_s_contact_city_state_zip"
    Then I should see "field_s_contact_fax"
    Then I should see "field_s_contact_phone"
    Then I should see "field_s_contact_link"
    Then I should see "field_s_contact_email"
    Then I should see "view_mode"

  @safe
  Scenario: Stanford Content Block Type Display Modes
    Given I am on "admin/structure/block-types/manage/stanford-contact/display"
    Then I should see "Address"
    Then I should see "group_s_contact_us_address"
    Then I should see "Address Line 1"
    Then I should see "Address Line 2"
    Then I should see "Address Line 3"
    Then I should see "City, State, Zip"
    Then I should see "Phone"
    Then I should see "Fax"
    Then I should see "Email"
    Then I should see "Link"
    Then I should see "No field is hidden."

  @dev @destructive
  Scenario: Create stanford contact block
    And I am on "block/add/stanford-contact"
    Then I fill in "edit-label" with "Behat Contact Block"
    Then I fill in "edit-title" with "Behat Contact Block"
    Then I fill in "field_s_contact_address_line_1[und][0][value]" with "Line one"
    Then I fill in "field_s_contact_address_line_2[und][0][value]" with "Line two"
    Then I fill in "field_s_contact_address_line_3[und][0][value]" with "Line three"
    Then I fill in "field_s_contact_city_state_zip[und][0][value]" with "City state zip"
    Then I fill in "field_s_contact_fax[und][0][value]" with "Fax number"
    Then I fill in "field_s_contact_phone[und][0][value]" with "Phone number"
    Then I fill in "field_s_contact_link[und][0][title]" with "Link title is me"
    Then I fill in "field_s_contact_link[und][0][url]" with "http://www.stanford.edu"
    Then I fill in "field_s_contact_email[und][0][email]" with "admin@stanford.edu"
    Then I press "Save"
    Then I should see "stanford_contact Behat Contact Block has been created."
    Then I should see "Behat Contact Block"
    Then I should see "Line one"
    Then I should see "Line two"
    Then I should see "Line three"
    Then I should see "City state zip"
    Then I should see "Phone number"
    Then I should see "Fax number"
    Then I should see "admin@stanford.edu"
    Then I should see "Link title is me"
    Then I click "Delete Block"
    Then I press "Delete"
    Then I should see "stanford_contact Behat Contact Block has been deleted."
