Feature: Ensure Image Caption functionality is available and that items on the Image Caption Catalog page appear as expected
  In order to ensure expected Image Caption functionality
  As an administrator
  I want to be able to see the styles on the Image Caption Catalog page
  # and the styles in the dropdown.

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe @api
  Scenario: Verify editor can see the styles on the Pattern Catalog page
    Given I am on "catalog-patterns/creating-content/adding-image-and-caption"
    And I should see 1 or more ".image-caption-left" elements
    And I should see 1 or more ".image-caption-right" elements


