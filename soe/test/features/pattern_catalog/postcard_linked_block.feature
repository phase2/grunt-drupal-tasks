Feature: Ensure items on the Postcard Blocks Catalog page appear as expected
  In order to ensure items on the Postcard Blocks Catalog page appear as expected
  As an administrator
  I want to be able to view all the Postcard Blocks Catalog page blocks

  Background:
    Given I am logged in as a user with the "administrator" role
    Given I am on "catalog-patterns/blocks-and-beans/postcard-blocks"

#  @safe @api
#  Scenario: Verify users can view the FW Banner People Spotlight view block
#    Then I should see a "#block-views-bbb1d0aad8bd2c65a848de02f62a1462" element
#    Then I should see a "#block-views-bbb1d0aad8bd2c65a848de02f62a1462.span12.no-margin" element
#
#  @safe @api
#  Scenario: Verify users can view the FW Banner People Spotlight view block
#    Then I should see a "#block-views-737269f96e2fed913cd92d19b37073e7" element
#    Then I should see a "#block-views-737269f96e2fed913cd92d19b37073e7.span12.next-row" element
