Feature: Stanford Affiliate Organization
  In order to verify the functionality of Affiliates Organizations
  As a visitor to the site I want to be able to view pages.
  As an administrator, site owner, or editor
  I want to be able to create, edit, delete, view, and manage affiliate organization nodes.

  @api @safe
  Scenario: Check for fields
    Given I am logged in as a user with the "administrator" role
    Given I am on "node/add/stanford-affiliate-organization"
    Then I should see "Name" in the "Content" region
    Then I should see "Image" in the "Content" region
    Then I should see "Link" in the "Content" region
    Then I should see "About" in the "Content" region

  @api @dev @destructive
  Scenario: administrator can create and manage affiliate organizations
    Given I am logged in as a user with the "administrator" role
    When I go to "node/add/stanford-affiliate-organization"
    Then I should see "Create Affiliate Organization" in the "Branding" region
    Then I fill in "edit-title" with "Foo"
    Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-affiliate-image-und-0-upload"
    Then I press "Upload"
    Then I press "Save"
    Then I should see 1 or more ".field-name-field-s-affiliate-image" elements
    Then I go to "admin/manage/stanford_affiliate_organizations"
    Then I should see 1 or more ".views-field-field-s-affiliate-image" elements
