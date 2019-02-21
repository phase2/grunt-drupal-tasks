Feature: Hoover Homepage Layout
  In order to ensure that the Jumpstart "Hoover" dynamic page layout is configured correctly
  As an end user
  I want to check for the existence of content that should appear

  @api @dev @destructive @javascript
  Scenario: Enable the Hoover homepage layout as administrator
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I press the "edit-layouts-stanford-jumpstart-home-hoover-selector" button

  @deploy
  Scenario Outline: Header content for hoover homepage
    Given I am on the homepage
    Then I should see the "<Header>" heading in the "<Region>" region

  Examples:
    | Header                | Region                |
    | About                 | Main Top              |
    | Small Custom Block    | Content Lower         |
    | Large Custom Block    | Content Lower         |
    | Affiliates            | Main Bottom           |
    | Contact Us            | Footer                |

  @deploy
  Scenario Outline: Homepage content hoover
    Given I am on the homepage
    Then I should see "<Text>" in the "<Region>" region

  Examples:
    | Text                                            | Region                |
    | This is your About block                        | Main Top              |
    | You can use this block to highlight content     | Content Lower         |
    | This is your large custom block                 | Content Lower         |
    | This is your custom                             | Footer                |

  @safe
  Scenario Outline: Homepage links on hoover
    Given I am on the homepage
    Then I should see the link "<Link>" in the "<Region>" region

  Examples:
    | Link                          | Region                |
    | More about us                 | Main Top              |
    | Learn more                    | Content Lower         |
    | Learn more                    | Content Lower         |

  @deploy
  Scenario: Affiliate Organizations page is visible and link in the main menu
    Given I am on the homepage
    Then I should see "Affiliates" in the "Main Bottom" region
    Then I should see 5 or more ".views-field-field-s-affiliate-image" elements

  @deploy
  Scenario: Homepage image Hoover
    Given I am on the homepage
    Then I should see 1 ".field-name-field-s-image-image" element in the "Main Top" region
