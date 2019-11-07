Feature: Ensure items on the Postcard Linked Blocks Catalog page appear as expected
  In order to ensure items on the Postcard Linked Blocks Catalog page appear as expected
  As an administrator
  I want to be able to view all the Postcard Blocks Catalog page blocks


  Background:
    Given I am logged in as a user with the "administrator" role
    Given I am on "catalog-patterns/blocks-and-beans/postcard-linked-blocks"

  @safe @api
  Scenario: Verify users can view the Give block
    Then I should see a "#block-bean-give" element

  @safe @api
  Scenario: Verify users can view the Planned Giving block
    Then I should see a "#block-bean-5-reasons-row-of-three-block" element

  @safe @api
  Scenario: Verify users can view the Engineering Fund block
    Then I should see a "#block-bean-5-reasons-row-of-three-blo-0" element

  @safe @api
  Scenario: Verify users can view the How to make your Gift block
    Then I should see a "#block-bean-5-reasons-row-of-three-blo-1" element

  @safe @api
  Scenario: Verify users can view the first postcard-linked block
    Then I should see a "#block-bean-test-postcard-linked-block-1" element

  @safe @api
  Scenario: Verify users can view the second postcard-linked block
    Then I should see a "#block-bean-test-postcard-linked-block-2" element

  @safe @api
  Scenario: Verify users can view the third postcard-linked block
    Then I should see a "#block-bean-test-postcard-linked-block-3" element

  @safe @api
  Scenario: Verify users can view the Undergraduates block
    Then I should see a "#block-bean-admission-aid-undergraduates" element

  @safe @api
  Scenario: Verify users can view the Graduates block
    Then I should see a "#block-bean-admission-aid-graduates" element

  @safe @api
  Scenario: Verify users can view the Course Planning block
    Then I should see a "#block-bean-admission-aid-course-planning" element

