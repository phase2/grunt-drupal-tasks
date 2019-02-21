@api
Feature: Stanford Paragraph Types
  In order to ensure that the Stanford Paragraphs Types installs properly
  As an end user
  I want to verify the display of content.

  Background:
    Given I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-story-page"
    And I fill in "title" with "Behat Test Stanford Page"

  @safe
  Scenario: Check for fields on Stanford Page
    Then I should see "Title"
    And I should see "Hide Page Title"
    And I should see "Sections"
    And I should see "Paragraph type"
    And I should see "Add new Paragraph"

  @safe
  Scenario: Create a Stanford Story Page with Buttons Type
    When I select "Buttons" from "Paragraph type"
    And I press the "Add new Paragraph" button
    Then I should see "Paragraph type: Buttons"
    And I should see "Button"
    Then I fill in "field_s_story_sections[und][0][field_p_buttons_button][und][0][title]" with "Link #1"
    And I fill in "field_s_story_sections[und][0][field_p_buttons_button][und][0][url]" with "google.com"
    And I press the "Add another item" button
    And I fill in "field_s_story_sections[und][0][field_p_buttons_button][und][1][title]" with "Link #2"
    And I fill in "field_s_story_sections[und][0][field_p_buttons_button][und][1][url]" with "stanford.com"
    And I press the "Save" button
    Then I should be on "behat-test-stanford-page"
    And I should see "Link #1"
    And I should see "Link #2"

  @safe
  Scenario: Create a Stanford Story Page with Callout Text Type
    When I select "Callout Text" from "Paragraph type"
    And I press the "Add new Paragraph" button
    Then I should see "Paragraph type: Callout Text"
    # Callout Text.
    And I fill in "field_s_story_sections[und][0][field_p_callout_text][und][0][value]" with "<p>This is some callout text</p>"
    # More Link.
    And I fill in "field_s_story_sections[und][0][field_p_callout_more_link][und][0][title]" with "Link #1"
    And I fill in "field_s_story_sections[und][0][field_p_callout_more_link][und][0][url]" with "google.com"
    And I press the "Save" button
    And I should be on "behat-test-stanford-page"
    And I should see "This is some callout text"
    And I should see "Link #1"


  @safe @javascript
  Scenario: Create a Stanford Story Page with Teaser Cards Type
    When I select "Teaser Cards" from "Paragraph type"
    And I press the "Add new Paragraph" button
    And I wait for AJAX to finish
    Then I should see "Paragraph type: Teaser Cards"
    # First Card.
    Then I select the "File" radio button
    And I should not see "Read More Link"
    Then I select the "Link" radio button
    And I fill in "field_s_story_sections[und][0][field_p_cards_card][und][0][field_p_card_title][und][0][value]" with "Card #1"
    And I fill in "field_s_story_sections[und][0][field_p_cards_card][und][0][field_p_card_text][und][0][value]" with "A blurb about the card"
    And I fill in "field_s_story_sections[und][0][field_p_cards_card][und][0][field_p_card_cta][und][0][title]" with "Call to Action Button 1"
    And I fill in "field_s_story_sections[und][0][field_p_cards_card][und][0][field_p_card_cta][und][0][url]" with "google.com"
    # Second Card.
    Then I press the "Add another item" button
    And I wait for AJAX to finish
    And I fill in "field_s_story_sections[und][0][field_p_cards_card][und][1][field_p_card_title][und][0][value]" with "Card #2"
    And I fill in "field_s_story_sections[und][0][field_p_cards_card][und][1][field_p_card_text][und][0][value]" with "Another blurb about this card"
    And I fill in "field_s_story_sections[und][0][field_p_cards_card][und][1][field_p_card_cta][und][0][title]" with "Call to Action Button 2"
    And I fill in "field_s_story_sections[und][0][field_p_cards_card][und][1][field_p_card_cta][und][0][url]" with "google.com"
    # Save and Validate.
    Then I press the "Save" button
    And I should be on "behat-test-stanford-page"
    And I should see "Card #1"
    And I should see "A blurb about the card"
    And I should see "Call to Action Button 1"
    And I should see "Card #2"
    And I should see "Another blurb about this card"
    And I should see "Call to Action Button 2"

  @safe @javascript
  Scenario: Create a Stanford Story Page with Hero Type
    When I select "Hero" from "Paragraph type"
    And I press the "Add new Paragraph" button
    And I wait for AJAX to finish
    Then I should see "Paragraph type: Hero"
    Then I select the "Image Only" radio button
    And I should see "Hero Image"
    And I should not see "Hero Video"
    Then I select the "Video Only" radio button
    And I should not see "Hero Image"
    And I should see "Hero Video"
    Then I select the "Video W/ Image Overlay" radio button
    And I should see "Hero Image"
    And I should see "Hero Video"

    Then I select the "Video Only" radio button
    Then I fill in "Video URL" with "https://youtu.be/uLcS7uIlqPo"
    And I fill in "Superhead" with "Super Head Text"
    And I fill in "Headline" with "Headline Text"
    And I fill in "field_s_story_sections[und][0][field_p_hero_more_link][und][0][title]" with "Read More"
    And I fill in "field_s_story_sections[und][0][field_p_hero_more_link][und][0][url]" with "google.com"

    And I press the "Save" button
    And I should be on "behat-test-stanford-page"
    And I should see "Super Head Text"
    And I should see "Headline Text"
    And I should see "Read More"

  @safe
  Scenario: Create a Stanford Story Page with WYSIWYG Type
    When I select "Text Area" from "Paragraph type"
    And I press the "Add new Paragraph" button
    Then I should see "Paragraph type: Text Area"
    Then I fill in "field_s_story_sections[und][0][field_p_wysiwyg_title][und][0][value]" with "Headline Text"
    And I fill in "field_s_story_sections[und][0][field_p_wysiwyg_body][und][0][value]" with "Some WYSIWYG Text"
    Then I press the "Save" button
    And I should be on "behat-test-stanford-page"
    And I should see "Headline Text"
    And I should see "Some WYSIWYG Text"
