Feature: Ensure items on the Admission and Aid landing page appear as expected
  In order to ensure items on the Admission and Aid landing page appear as expected
  As a Site User
  I want to be able to view all the Admission and Aid landing page blocks in their appropriate regions

  Background:
    Given I am on "admission-aid"

  @safe
  Scenario: Verify users can view all the blocks
    Then I should see 3 or more ".bean-stanford-call-to-action" elements
    Then I should see 5 or more ".bean-stanford-postcard-linked" elements
    Then I should see 1 or more ".block-views" elements

  @safe
  Scenario: Verify users can view the WYSIWYG text
    Then I should see a ".field-name-body" element
    Then I should see the text "Admission and financial aid"

  @safe
  Scenario: Verify users can view the first postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-admission-aid-undergraduates" element
    Then I should see a "#block-bean-admission-aid-undergraduates.span6.well.no-padding.next-row" element
    Then I should see the text "Apply"

  @safe
  Scenario: Verify users can view the second postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-admission-aid-graduates" element
    Then I should see a "#block-bean-admission-aid-graduates.span6.well.no-padding" element
    Then I should see the text "Graduate Admissions"

  @safe
  Scenario: Verify users can view the third postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-admission-aid-coterm" element
    Then I should see a "#block-bean-admission-aid-coterm.span12.next-row.well.no-padding" element

  @safe
  Scenario: Verify users can view the fourth postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-admission-aid-financial-aid.span12.well.no-padding" element

  @safe
  Scenario: Verify users can view the fifth postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-admission-aid-course-planning" element
    Then I should see a "#block-bean-admission-aid-course-planning.span6.next-row.well.no-padding" element

  @safe
  Scenario: Verify users can view the people spotlight
    Then I should see 1 or more "#block-views-3e74637834ad4498173a247962038d31" elements
    Then I should see the "img" element in the "Content Lower" region
    Then I should see a "a" element in the "Content Lower" region
