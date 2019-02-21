Feature: Ensure items on the About landing page appear as expected
  In order to ensure items on the About landing page appear as expected
  As a Site User
  I want to be able to view all the About landing page blocks in their appropriate regions

  Background:
    Given I am on "about/soe-future"

  @safe
  Scenario: Verify users can view all the blocks
    Then I should see 6 or more ".bean-stanford-postcard-linked" elements

  @safe
  Scenario: Verify users can view the first postcard linked block
    Then I should see a "#block-bean-soe-future-about-the-soe-future" element
    Then I should see a "#block-bean-soe-future-about-the-soe-future.span6.next-row.well.no-padding" element

  @safe
  Scenario: Verify users can view the second postcard linked block
    Then I should see a "#block-bean-soe-future-the-impact" element
    Then I should see a "#block-bean-soe-future-the-impact.span6.well.no-padding" element

  @safe
  Scenario: Verify users can view the Research (third) postcard linked block
    Then I should see a "#block-bean-soe-future-research-block" element
    Then I should see a "#block-bean-soe-future-research-block.span12.well.next-row.no-padding" element

  @safe
  Scenario: Verify users can view the Education (fourth) postcard linked block
    Then I should see a "#block-bean-soe-future-education" element
    Then I should see a "#block-bean-soe-future-education.span12.well.next-row.no-padding" element

  @safe
  Scenario: Verify users can view the Mission (yeah, the block says Culture) (fifth) postcard linked block
    Then I should see a "#block-bean-soe-future-culture" element
    Then I should see a "#block-bean-soe-future-culture.span12.well.next-row.no-padding" element

  @safe
  Scenario: Verify users can view the Culture (yeah, the block says Mission) (sixth) postcard linked block
    Then I should see a "#block-bean-soe-future-mission-block" element
    Then I should see a "#block-bean-soe-future-mission-block.span12.well.next-row.no-padding" element

