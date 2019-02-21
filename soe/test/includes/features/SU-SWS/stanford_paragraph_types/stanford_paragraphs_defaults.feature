@api
Feature: Stanford Paragraphs Defaults
  In order to ensure that the Stanford Paragraphs Defaults functions properly
  As an end user
  I want to verify the display of content.

  @destructive
  Scenario: Validate paragraphs defaults functions correctly.
    Given I am logged in as a user with the "administrator" role
    And the "stanford_paragraph_types" module is enabled

    # Create a content type with paragraph field.
    Then I am on "admin/structure/types/add"
    And I fill in "Name" with "Behat Paragraphs Defaults"
    And I fill in "Machine-readable name" with "behat_paragraphs_defaults"
    Then I press the "Save and add fields" button
    Then I fill in "fields[_add_new_field][label]" with "Paragraphs"
    And I fill in "fields[_add_new_field][field_name]" with "behat_paragraphs"
    And I select "Paragraphs" from "fields[_add_new_field][type]"
    And I select "Embedded" from "fields[_add_new_field][widget_type]"
    Then I press the "Save" button
    And I press the "Save field settings" button
    Then I select "Unlimited" from "field[cardinality]"
    And I press the "Save settings" button
    And I should see "Saved Paragraphs configuration"

    # Create the default config.
    Then I am on "admin/structure/paragraphs/stanford-defaults"
    Then I should see "Paragraphs Defaults"
    And I should see "Node - Behat Paragraphs Defaults - field_behat_paragraphs"
    Then I am on "/admin/structure/paragraphs/stanford-defaults/add/node/behat_paragraphs_defaults/field_behat_paragraphs"
    And I should see "Set paragraph defaults for field_behat_paragraphs on node: behat_paragraphs_defaults"
    Then I fill in "Label" with "First Default"
    And I fill in "Machine Name" with "first_default"
    Then I select "Hero" from "Paragraph type"
    And I press the "Add new Paragraph" button
    Then I select the "Video Only" radio button
    And I fill in "field_behat_paragraphs[und][0][field_p_hero_video][und][0][video_url]" with "https://www.youtube.com/watch?v=fYfv-SIQn1g"
    And I fill in "field_behat_paragraphs[und][0][field_p_hero_superhead][und][0][value]" with "Superhead"
    Then I press the "Save" Button
    Then I should be on "admin/structure/paragraphs/stanford-defaults"
    And I should see "First Default"

    # Create a node with the default.
    Then I am on "node/add/behat-paragraphs-defaults"
    And I should see "Start with a default layout"
    Then I press the "First Default" button
    Then I should see "Paragraph type: Hero"
    And the "field_behat_paragraphs[und][0][field_p_hero_video][und][0][video_url]" field should contain "https://www.youtube.com/watch?v=fYfv-SIQn1g"
    And the "field_behat_paragraphs[und][0][field_p_hero_superhead][und][0][value]" field should contain "Superhead"
    And I fill in "title" with "Behat content test"
    Then I press the "Save" button
    And I should see 1 or more ".field-name-field-p-hero-video iframe" elements
    And I should see "Superhead"

    # Cleanup
    Then I click "Edit"
    And I press the "Delete" button
    And I press the "Delete" button
    Then I am on "admin/structure/paragraphs/stanford-defaults/delete/node-behat_paragraphs_defaults-field_behat_paragraphs-first_default"
    And I press the "Delete" button
    Then I am on "admin/structure/types/manage/behat-paragraphs-defaults/delete"
    And I press the "Delete" button
