Feature: Ensure items on the Faculty and Research landing page appear as expected
  In order to ensure items on the Faculty and Research landing page appear as expected
  As a Site User
  I want to be able to view all the Faculty and Research landing page blocks in their appropriate regions

  Background:
    Given I am on "faculty-research"

  @safe
  Scenario: Verify users can view the top banner
    Then I should see the "img" element in the "Top Full Width" region
    Then I should see 1 or more ".image-style-full-width-banner-short" elements

  @safe
  Scenario: Verify users can view all the blocks
    Then I should see 3 or more ".bean-stanford-call-to-action" elements
    Then I should see 2 or more ".bean-stanford-postcard-linked" elements
    Then I should see 1 or more ".block-views" elements

  @safe
  Scenario: Verify users can view the WYSIWYG text
    Then I should see a ".field-name-body" element
    Then I should see the text "Engineering can solve"

  @safe
  Scenario: Verify users can view the double people spotlight
    Then I should see 1 or more "#block-views-fa8e1c688b5924f9151e40818be634fe" elements
    Then I should see the "img" element in the "Content Lower" region
    Then I should see a "a" element in the "Content Lower" region

  @safe
  Scenario: Verify users can view the first postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-research-overview-deopartments" element
    Then I should see a "#block-bean-research-overview-deopartments.span12.next-row.well.no-padding.no-margin" element

  @safe
  Scenario: Verify users can view the second postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-research-overview-labs-and-cente" element
    Then I should see a "#block-bean-research-overview-labs-and-cente.span12.next-row.well.no-padding.no-margin" element
