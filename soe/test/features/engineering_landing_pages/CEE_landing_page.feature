Feature: Ensure items on the CEE landing page appear as expected
  In order to ensure items on the CEE landing page appear as expected
  As a Site User
  I want to be able to view all the CEE landing page blocks in their appropriate regions

  Background:
    Given I am on "faculty-research/departments/civil-environmental-engineering"

  @safe
  Scenario: Verify users can view the top banner
    Then I should see the "img" element in the "Top Full Width" region
    Then I should see 1 or more ".image-style-full-width-banner-short" elements

  @safe
  Scenario: Verify users can view all the blocks
    Then I should see 3 or more ".bean-stanford-postcard" elements
    Then I should see 3 or more ".bean-stanford-postcard-linked" elements
    Then I should see 1 or more ".block-views" elements

  @safe
  Scenario: Verify users can view the WYSIWYG text
    Then I should see a ".field-name-body" element
    Then I should see the text "Civil and Environmental"

  @safe
  Scenario: Verify users can view the first postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-civil-environmental-engineering" element
    Then I should see a "#block-bean-civil-environmental-engineering.span12.next-row.well.no-margin.no-padding" element

  @safe
  Scenario: Verify users can view the people spotlight
    Then I should see 1 or more ".view-stanford-people-spotlight-h-card" elements
    Then I should see the "img" element in the "Content Lower" region
    Then I should see a "a" element in the "Content Lower" region
    Then I should see the text "More Stories"

  @safe
  Scenario: Verify users can view the second postcard linked block
    Then I should see a "a" element in the "Content Bottom" region
    Then I should see a "#block-bean-civil-environmental-engineeri-0" element
    Then I should see a "#block-bean-civil-environmental-engineeri-0.span12.next-row.well.no-margin.no-padding" element

  @safe
  Scenario: Verify users can view the third postcard linked block
    Then I should see a "a" element in the "Content Bottom" region
    Then I should see a "#block-bean-civil-environmental-engineeri-1" element
    Then I should see a "#block-bean-civil-environmental-engineeri-1.span12.next-row.well.no-margin.no-padding" element

  @safe
  Scenario: Verify users can view the Information For block
    Then I should see a "a" element in the "Content Bottom" region
    Then I should see a "#block-bean-civil-environmental-engineeri-2" element
    Then I should see a "#block-bean-civil-environmental-engineeri-2.span6.next-row.well" element

  @safe
  Scenario: Verify users can view the related magazine article view
    Then I should see a "a" element in the "Content Bottom" region
    Then I should see a ".view-stanford-magazine-article-department" element
    Then I should see the text "Visit the"
