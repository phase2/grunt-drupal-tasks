Feature: Ensure items on the SoE Future landing page appear as expected
  In order to ensure items on the SoE Future landing page appear as expected
  As a Site User
  I want to be able to view all the SoE Future landing page blocks in their appropriate regions

  @safe
  Scenario: Verify users can view the top banner
    Given I am on "about/soe-future"
    Then I should see the "img" element in the "Top Full Width" region
    Then I should see 1 or more ".image-style-full-width-banner-short" elements

  @safe
  Scenario: Verify users can view all the blocks
    Given I am on "about/soe-future"
    Then I should see 3 or more ".bean-stanford-call-to-action" elements
    Then I should see 6 or more ".bean-stanford-postcard-linked" elements

  @safe
  Scenario: Verify users can view the WYSIWYG text
    Given I am on "about/soe-future"
    Then I should see a ".field-name-body" element
    Then I should see the text "In early 2015, Stanford"

  @safe
  Scenario: Verify users can view the first postcard linked block
    Given I am on "about/soe-future"
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-soe-future-about-the-soe-future" element

  @safe
  Scenario: Verify users can view the second postcard linked block
    Given I am on "about/soe-future"
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-soe-future-the-impact" element

  @safe
  Scenario: Verify users can view the third postcard linked block
    Given I am on "about/soe-future"
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-soe-future-research-block" element

  @safe
  Scenario: Verify users can view the fourth postcard linked block
    Given I am on "about/soe-future"
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-soe-future-education" element

  @safe
  Scenario: Verify users can view the fifth postcard linked block
    Given I am on "about/soe-future"
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-soe-future-culture" element

  @safe
  Scenario: Verify users can view the sixth postcard linked block
    Given I am on "about/soe-future"
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-soe-future-mission-block" element
