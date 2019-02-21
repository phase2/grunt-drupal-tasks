@deploy
Feature: Lomita Homepage Layout
  In order to ensure that the Jumpstart "Lomita" page layout is configured correctly
  As an end user
  I want to check for the existence of content that should appear
  (Tests in this Feature should fail if Lomita is not the selected homepage layout)

  @api @destructive @dev
  Scenario: Enable the Lomita homepage layout as administrator
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I press the "edit-layouts-stanford-jumpstart-home-panama-selector" button
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I press the "edit-layouts-stanford-jumpstart-home-lomita-selector" button
    Then I should see "Customized design options saved"

  @api @safe
  Scenario: Editor should not access Customize Design
    Given I am logged in as a user with the "editor" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I should see the heading "Access denied" in the "Branding" region

  @api @deploy
  Scenario Outline: Homepage content
    Given I am on the homepage
    And the cache has been cleared
    Then I should see "<Text>" in the "<Region>" region

  Examples:
    | Text | Region   |
    | Feature a tagline or website subtitle here | Main Top |
    | To edit the block and remove this placeholder content, hover over the block, click on the gear widget and select | Main Top |
    | Add a video, image, or other featured content to this block. | Main Top |
    | Building Name Room 555 | Footer   |

  @api @safe
  Scenario: Homepage video block
    Given I am on the homepage
    And the cache has been cleared
    Then I should see an "iframe" element
