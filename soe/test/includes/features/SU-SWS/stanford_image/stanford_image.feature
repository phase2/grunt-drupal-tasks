Feature: Stanford Image
  In order to ensure that upgrades do not break existing functionality
  As an administrative user
  I want to ensure that the Stanford Image module is working properly

  @api @safe
  Scenario: Stanford Image
    Given the cache has been cleared
    And I am logged in as a user with the "administrator" role
    When I go to "admin/structure/field-collections/field-s-image-info/fields"
    Then I should see "group_s_image"
    And I should see "field_s_image_image"
    And I should see "field_s_image_credits"
    And I should see "field_s_image_source_info"
    And I should see "field_s_image_caption"
    When I go to "admin/structure/field-collections/field-s-image-info/display"
    Then I should see "group_s_image_border_style"

  @api @safe
  Scenario: Stanford Image Views
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford/images"
    Then I should see the heading "Bulk Image Operations"
