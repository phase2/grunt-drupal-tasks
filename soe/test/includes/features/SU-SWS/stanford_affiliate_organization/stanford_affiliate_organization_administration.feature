Feature: Stanford Affiliate Organization Administration
  In order to ensure that I can administer Affiliate Organizations
  As an administrator
  I want to be able verify functionality of the manage content pages

  @api @safe
  Scenario: Check for affiliates view
    Given I am logged in as a user with the "administrator" role
    Given I am on "admin/structure/views"
    Then I should see "Affiliates" in the "Content" region

  @api @safe
  Scenario: Check for manage affiliates view
    Given I am logged in as a user with the "administrator" role
    Given I am on "admin/manage/stanford_affiliate_organizations"
    Then I should see "Manage Stanford Affiliate Organizations" in the "Branding" region

  @api @safe
  Scenario: Check for manage affiliates view manage link
    Given I am logged in as a user with the "administrator" role
    Given I am on "admin/manage"
    Then I should see "Manage Affiliate Organizations" in the "Second sidebar" region

  @api @safe
  Scenario: Check for affiliates view
    Given I am logged in as a user with the "administrator" role
    Given I am on "admin/structure/views"
    Then I should see "Affiliates" in the "Content" region

  @api @safe
  Scenario: Check for manage affiliates view
    Given I am logged in as a user with the "administrator" role
    Given I am on "admin/manage/stanford_affiliate_organizations"
    Then I should see "Manage Stanford Affiliate Organizations" in the "Branding" region

  @api @safe
  Scenario: Check for manage affiliates view manage link
    Given I am logged in as a user with the "administrator" role
    Given I am on "admin/manage"
    Then I should see "Manage Affiliate Organizations" in the "Second sidebar" region
