@deploy
Feature: Stanford Jumpstart Home Feature
  In order to ensure that the Stanford Jumpstart Home feature is configured correctly
  As an administrator
  I want to check for the existence of content that should appear

  @api @safe
  Scenario: Verify items on the Customized Design Page
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I should see "Serra" in the "Content Body" region
    And I should see "Lomita" in the "Content Body" region
    And I should see "Panama" in the "Content Body" region
    And I should see "Mayfield" in the "Content Body" region
    And I should see "Dark" in the "Content Body" region
    And I should see "Bright" in the "Content Body" region

  @api @safe
  Scenario: Verify the big text checkbox is available
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I should see "Include BIG text"
    Then I track variable "stanford_jumpstart_home_include_flat_styles"
    And I track variable "preprocess_css"
    Then I run drush "vset" "preprocess_css 0"
    And I check the box "Include BIG text"
    And I press the "Save settings" button
    Then I am on the homepage
    And I should see "stanford_jumpstart_home_typography.css"
