Feature: Ensure items on the Engineering Diversity landing page appear as expected
  In order to ensure items on the Engineering Diversity landing page appear as expected
  As a Site User
  I want to be able to view all the Engineering Diversity landing page blocks in their appropriate regions

  Background:
    Given I am on "students-academics/engineering-diversity-programs"

  @safe
  Scenario: Verify users can view the top banner
    Then I should see the "img" element in the "Top Full Width" region
    Then I should see 1 or more ".image-style-full-width-banner-short" elements

  @safe
  Scenario: Verify users can view all the blocks
    Then I should see 3 or more ".bean-stanford-call-to-action" elements
    Then I should see 5 or more ".bean-stanford-postcard-linked" elements
    Then I should see 1 or more ".block-views" elements

  @safe
  Scenario: Verify users can view the WYSIWYG text
    Then I should see a ".field-name-body" element
    Then I should see the text "Engineering Diversity"

  @safe
  Scenario: Verify users can view the first postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-diversity-programs-financial-aid" element
    Then I should see a "#block-bean-diversity-programs-financial-aid.span12.well.no-padding.no-margin" element

  @safe
  Scenario: Verify users can view the second postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-diversity-programs-pre-college" element
    Then I should see a "#block-bean-diversity-programs-pre-college.span12.well.no-padding.no-margin" element

  @safe
  Scenario: Verify users can view the third postcard linked block
    Then I should see a "a" element in the "Content Bottom" region
    Then I should see a "#block-bean-diversity-programs-summer-progra" element
    Then I should see a "#block-bean-diversity-programs-summer-progra.span6.well.no-padding" element

  @safe
  Scenario: Verify users can view the fourth postcard linked block
    Then I should see a "a" element in the "Content Bottom" region
    Then I should see a "#block-bean-diversity-programs-graduate-prog" element
    Then I should see a "#block-bean-diversity-programs-graduate-prog.span6.well.no-padding" element

  @safe
  Scenario: Verify users can view the fifth postcard linked block
    Then I should see a "a" element in the "Content Bottom" region
    Then I should see a "#block-bean-diversity-programs-opportunity-j" element
    Then I should see a "#block-bean-diversity-programs-opportunity-j.span12.well.no-padding.no-margin" element

  @safe
  Scenario: Verify users can view the people spotlight
    Then I should see 1 or more "#block-views-030921f815967f2aa26011e22a507420" elements
    Then I should see the "img" element in the "Content Bottom" region
    Then I should see a "a" element in the "Content Bottom" region
