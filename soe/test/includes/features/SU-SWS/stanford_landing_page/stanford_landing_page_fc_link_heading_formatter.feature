Feature: Stanford Landing Page FC Link Heading Formatter
  In order to ensure the field formatter works correctly
  As an administrative user
  I want edit a fields display settings.

  @api @safe
  Scenario: The display option for a text field is available.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/field-collections/field_landing_page_item/display/large_landscape"
    Then I select "Link Heading - Stanford Landing Page" from "fields[field_s_lp_item_title][type]"
    And I press the "Save" button
    And I press the "edit-fields-field-s-lp-item-title-settings-edit" button
    And I select "H2" from "fields[field_s_lp_item_title][settings_edit_form][settings][html_tag]"
    And I select "field_s_lp_item_link" from "fields[field_s_lp_item_title][settings_edit_form][settings][link_field]"
    And I press the "Save" button
    Then I should see "Heading tag: h2"
    And I should see "Links to: field_s_lp_item_link"

  @api @safe
  Scenario: Create Landing Page and check FC Link Heading Formatter
    Given I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-landing-page"
    Then I fill in "title" with "FC Link Formatter Test"
    And I select "Cards" from "field_s_landing_page_layout[und]"
    And I fill in "field_landing_page_item[und][0][field_s_lp_item_title][und][0][value]" with "Card #1"
    And I attach the file "features/stanford_landing_page/img/ooooaaaahhh.jpg" to "files[field_landing_page_item_und_0_field_s_lp_item_image_und_0]"
    Then I press the "Save" button
    And I should see "Primary link is required"
    Then I fill in "field_landing_page_item[und][0][field_s_lp_item_link][und][0][url]" with "http://google.com"
    And I press the "Save" button
    Then I should see the heading "Card #1"
    And I click on the element with css selector ".field-name-field-s-lp-item-title a"
    Then I should see "Google"
    And I should be on "http://google.com"
