Feature: Stanford Jumpstart Home Feature
  In order to ensure that the Stanford Jumpstart Home feature is configured correctly for JSE
  As an end user
  I want to check for the existence of content that should appear

  @api @safe
  Scenario Outline: Verify items on the Customized Design Page
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I should see "<Text>" in the "<Region>" region

  Examples:
  | Text          | Region       |
  | Hoover        | Content Body |
  | Morris        | Content Body |
  | Terman        | Content Body |
  | Pettit        | Content Body |
  | Light         | Content Body |
  | Plain         | Content Body |
  | Rich          | Content Body |
  | High Contrast | Content Body |
  | Cardinal      | Content Body |
  | Sans Serif    | Content Body |
  | Serif         | Content Body |
  | Slab Serif    | Content Body |


  @api @safe
  Scenario Outline: Verify items on the Customized Design Page
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I should not see "<Text>" in the "<Region>" region

  Examples:
    | Text          | Region       |
    | Serra         | Content Body |
    | Lomita        | Content Body |
    | Panama        | Content Body |
    | Mayfield      | Content Body |
    | Dark          | Content Body |
    | Bright        | Content Body |



