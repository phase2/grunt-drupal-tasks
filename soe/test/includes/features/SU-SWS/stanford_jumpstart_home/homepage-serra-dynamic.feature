@deploy
Feature: Serra Homepage Layout
  In order to ensure that the Jumpstart "Serra" dynamic page layout is configured correctly
  As an end user
  I want to check for the existence of content that should appear

  @api @dev @destructive
  Scenario: Enable the Serra News and Events homepage layout as administrator
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I press the "edit-layouts-stanford-jumpstart-home-serra-news-events-selector" button

  @safe
  Scenario Outline: Header content for serra news and events
    Given I am on the homepage
    Then I should see the "<Header>" heading in the "<Region>" region

  Examples:
    | Header                | Region                |
    | About                 | Content 3 column flow |
    | Recent News           | Content 3 column flow |
    | Upcoming Events       | Content 3 column flow |

  @safe
  Scenario Outline: Homepage content for serra news and events
    Given I am on the homepage
    Then I should see "<Text>" in the "<Region>" region

  Examples:
    | Text | Region |
    | Feature a tagline or website subtitle here | Main Top |
    | To edit the block and remove this placeholder | Main Top |
    | 99.9% | Main Top |
    | This is your first Mission block. | Content 2 column flow |
    | This is your second Mission block. | Content 2 column flow |
    | Use this block to list facts or highlight information | Main Top |
    | This is your About block.  | Content 3 column flow |

  @safe
  Scenario Outline: Homepage links for serra news and events
    Given I am on the homepage
    Then I should see the link "<Link>" in the "<Region>" region

  Examples:
    | Link                          | Region                |
    | About us                      | Main Top              |
    | More about us                 | Content 3 column flow |
    | See more news                 | Content 3 column flow |
    | See more events               | Content 3 column flow |
