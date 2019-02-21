Feature: Morris Homepage Layout
  In order to ensure that the Jumpstart "Morris" dynamic page layout is configured correctly
  As an end user
  I want to check for the existence of content that should appear

  @api @dev @destructive @javascript
  Scenario: Enable the Morris News & Events homepage layout as administrator
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I press the "edit-layouts-stanford-jumpstart-home-morris-selector" button

  @deploy
  Scenario Outline: Header content for Morris
    Given I am on the homepage
    Then I should see the "<Header>" heading in the "<Region>" region

  Examples:
    | Header                | Region                |
    | About                 | Main Top              |
    | Small Custom Block    | Content 3 column flow |
    | Recent News           | Content 3 column flow |
    | Upcoming Events       | Content 3 column flow |

  @deploy
  Scenario Outline: Homepage content Morris
    Given I am on the homepage
    Then I should see "<Text>" in the "<Region>" region

  Examples:
    | Text                                            | Region                |
    | This is your About block                        | Main Top              |
    | Sample News                                     | Content 3 column flow |
    | You can use this block to highlight content     | Content 3 column flow |
    | See more events                                 | Content 3 column flow |

  @deploy
  Scenario Outline: Homepage links Morris
    Given I am on the homepage
    Then I should see the link "<Link>" in the "<Region>" region

  Examples:
    | Link                          | Region                |
    | More about us                 | Main Top              |
    | Learn more                    | Content 3 column flow |
    | See more news                 | Content 3 column flow |
    | See more events               | Content 3 column flow |

  @deploy
  Scenario: Homepage image Morris
    Given I am on the homepage
    Then I should see 1 ".field-name-field-s-image-image" element in the "Main Top" region

  @deploy
  Scenario: Affiliate Organizations page is visible and link on the main menu
    Given I am on the homepage
    Then I should see "Affiliates" in the "Main Bottom" region
    Then I should see 5 or more ".views-field-field-s-affiliate-image" elements
