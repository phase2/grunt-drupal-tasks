@deploy
Feature: Palm Homepage Layout
  In order to ensure that the Jumpstart "Palm" dynamic page layout is configured correctly
  As an end user
  I want to check for the existence of content that should appear

  @api @dev @destructive
  Scenario: Change homepage to palm news and events
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I press the "edit-layouts-stanford-jumpstart-home-palm-news-events-selector" button

  @safe
  Scenario Outline: Header content for palm news and events
    Given I am on the homepage
    Then I should see the "<Header>" heading in the "<Region>" region

  Examples:
    | Header                | Region                |
    | Welcome to your site! | Main Top              |
    | About                 | Content 3 column flow |
    | Recent News           | Content 3 column flow |
    | Upcoming Events       | Content 3 column flow |

  @safe
  Scenario Outline: Homepage content for plam news and events
    Given I am on the homepage
    Then I should see "<Text>" in the "<Region>" region

  Examples:
    | Text | Region |
    | Edit this block to change the image and caption. | Main Top |
    | This is your About block. | Content 3 column flow |
    | Sample News | Content 3 column flow |

  @safe
  Scenario Outline: Homepage links for palm news and events
    Given I am on the homepage
    Then I should see the link "<Link>" in the "<Region>" region

  Examples:
    | Link                          | Region                |
    | Example link                  | Main Top              |
    | More about us                 | Content 3 column flow |
    | See more news                 | Content 3 column flow |
    | See more events               | Content 3 column flow |
