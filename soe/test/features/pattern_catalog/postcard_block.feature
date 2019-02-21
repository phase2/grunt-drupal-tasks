Feature: Ensure items on the Postcard Blocks Catalog page appear as expected
  In order to ensure items on the Postcard Blocks Catalog page appear as expected
  As an administrator
  I want to be able to view all the Postcard Blocks Catalog page blocks

  Background:
    Given I am logged in as a user with the "administrator" role
    Given I am on "catalog-patterns/blocks-and-beans/postcard-blocks"


  @safe @api
  Scenario: Verify the Single Centered Button view mode displays as expected
    Then I should see a "#block-bean-test-postcard-block-6" element
    Then I should see a "#block-bean-test-postcard-block-6 .bean-stanford-postcard.view-mode-single_centered_button" element
    Then I should see a "#block-bean-test-postcard-block-6.span12.next-row.no-margin" element

