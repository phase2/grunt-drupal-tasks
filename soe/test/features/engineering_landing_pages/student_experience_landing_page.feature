Feature: Ensure items on the Student Experience landing page appear as expected
  In order to ensure items on the Student Experience landing page appear as expected
  As a Site User
  I want to be able to view all the Student Experience landing page blocks in their appropriate regions

  Background:
    Given I am on "students-academics/student-experience"

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
    Then I should see the text "Stanford Engineering"

  @safe
  Scenario: Verify users can view the double people spotlight
    Then I should see 1 or more "#block-views-c5911e9acf4c84491e5347eb4df7be0f" elements
    Then I should see the "img" element in the "Content Lower" region
    Then I should see a "a" element in the "Content Lower" region
    Then I should see the text "More Stories"

  @safe
  Scenario: Verify users can view the first postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-student-experience-the-campus" element
    Then I should see a "#block-bean-student-experience-the-campus.span12.next-row.well.no-padding.no-margin" element

  @safe
  Scenario: Verify users can view the second postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-student-experience-beyond-the-cl" element
    Then I should see a "#block-bean-student-experience-beyond-the-cl.span12.next-row.well.no-padding.no-margin" element
    Then I should see the text "Learn About Our Alumni"
    Then I should see the text "Learn About Our Faculty"

  @safe
  Scenario: Verify users can view the third postcard linked block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-student-experience-life-for-grad" element
    Then I should see a "#block-bean-student-experience-life-for-grad.span12.next-row.well.no-padding.no-margin" element

  @safe
  Scenario: Verify users can view the related links block
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-student-experience-related-links" element
    Then I should see a "#block-bean-student-experience-related-links.span6.well" element

  @safe
  Scenario: Verify users can view the events view
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-views-stanford-event-featured-block-1" element
