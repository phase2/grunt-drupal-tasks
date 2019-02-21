Feature: Ensure items on the Alumni landing page appear as expected
  In order to ensure items on the Alumni landing page appear as expected
  As a Site User
  I want to be able to view all the Alumni landing page blocks in their appropriate regions

  Background:
    Given I am on "get-involved/alumni"

  @safe
  Scenario: Verify users can view the top banner
    Then I should see the "img" element in the "Top Full Width" region
    Then I should see 1 or more ".image-style-full-width-banner-short" elements

  @safe
  Scenario: Verify users can view all the blocks
    Then I should see 3 or more ".bean-stanford-call-to-action" elements
    Then I should see 3 or more ".bean-stanford-postcard-linked" elements
    Then I should see 2 or more ".block-views" elements

  @safe
  Scenario: Verify users can view the WYSIWYG text
    Then I should see a ".field-name-body" element
    Then I should see the text "Stanford engineers are"

  @safe
  Scenario: Verify users can view the first postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-alumni-alumni-events" element
    Then I should see a "#block-bean-alumni-alumni-events.span6.well.no-padding" element

  @safe
  Scenario: Verify users can view the second postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-alumni-volunteer-block" element
    Then I should see a "#block-bean-alumni-volunteer-block.span6.well.no-padding" element

  @safe
  Scenario: Verify users can view the third postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-alumni-stay-connected-block" element
    Then I should see a "#block-bean-alumni-stay-connected-block.span12.next-row.well.no-margin.no-padding" element

  @safe
  Scenario: Verify users can view the people spotlight
    Then I should see 1 or more "#block-views-737269f96e2fed913cd92d19b37073e7" elements
    Then I should see the "img" element in the "Content Lower" region
    Then I should see a "a" element in the "Content Lower" region
    Then I should see the text "More Stories"

  @safe
  Scenario: Verify users can view the events view
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-views-stanford-event-featured-block-2" element
