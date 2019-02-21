Feature: Stanford Sites Helper Module
  In order to ensure that upgrades do not break existing functionality
  As an administrative user
  I want to ensure the Stanford Sites Helper module is working properly

  @live
  Scenario Outline: Homepage text content
    Given I am on the homepage
    Then I should see "<Text>" in the "<Region>" region

  Examples:
    | Text                                                                             | Region          |
    | Once you have logged in, you will be able to remove this text from your homepage | Content Body    |
    | Create a new page on your site                                                   | Content Body    |
    | Change your site's name and information                                          | Content Body    |
    | Get rid of this                                                                  | Content Body    |
    | Edit your navigation menus                                                       | Content Body    |
    | Add functionality and features                                                   | Content Body    |
    | Edit the look and feel of your site                                              | Content Body    |

  @live
  Scenario Outline: Homepage header content
    Given I am on the homepage
    Then I should see the heading "<Header>" in the "<Region>" region

  Examples:
    | Header                                 | Region        |
    | Welcome to Your Stanford Sites Website | Content Body  |
    | Quick Steps to Get Started             | Content Body  |
    | More advanced tasks:                   | Content Body  |
    | Going further:                         | Content Body  |

  @api @live
  Scenario: Search box - authenticated user
    Given I am logged in as a user with the "administrator" role
    And I am on the homepage
    Then I should see a "#edit-search-block-form--2" element
    When I enter "purple monkey dishwasher" for "Search"
    And I press the "Search" button
    Then I should be on "search/node/purple%20monkey%20dishwasher"
    And I should see the heading "Your search did not yield any results"
    And I should see "Remove quotes around phrases to match each word individually:"
    And I should see "stanford university"
    And I should see "will match less than stanford university."
    And I should see "Consider loosening your query with OR: stanford university will match less than stanford OR university."

  @api @javascript @live
  Scenario Outline: Quick Steps
    Given I am logged in as a user with the "administrator" role
    And I am on the homepage
    When I click "<Link>"
    Then I should see "<Text>"
    When I click "<Second Link>"
    Then I should be on "<Destination>"

  Examples:
    | Link                                    | Text                                                                               | Second Link                  | Destination                                                             |
    | Create a new page on your site          | Do you want an                                                                     | Create a New Page            | node/add/page                                                           |
    | Change your site's name and information | You can rename your site, add a slogan, or set an existing page to be the homepage | Edit Your Site's Information | admin/config/system/site-information                                    |
    | Get rid of this                         | Want to make these                                                                 | Hide This Block              | admin/structure/block/manage/stanford_sites_helper/firststeps/configure |
    | Get rid of this                         | Drupal uses a system called                                                        | Configure All Blocks         | admin/structure/block                                                   |
    | Edit your navigation menus              | Drupal comes pre-packaged with a Main menu navigation                              | Edit Your Main Menu          | admin/structure/menu/manage/main-menu                                   |
    | Edit your navigation menus              | First create new pages, and then add them to your menu                             | Create a New Menu            | admin/structure/menu/add                                                |
    | Add functionality and features          | Want to add a contact form to your site? Looking to do more with your site?        | Visit Your Modules           | admin/modules                                                           |
    | Edit the look and feel of your site     | Your site comes pre-packaged with the Stanford Light theme.                        | Edit Your Theme Settings     | admin/appearance/settings                                               |

  @api @live
  Scenario Outline: Going Further
    Given I am logged in as a user with the "administrator" role
    And I am on the homepage
    When I click "<Link>"
    Then I should be on "<Destination>"

  Examples:
    | Link                   | Destination                    |
    | Add a new user         | admin/people/create            |
    | Create a new user role | admin/people/permissions/roles |
    | Edit permissions       | admin/people/permissions       |
    | Create a new View      | admin/structure/views/add      |

  @api @live
  Scenario: Link to HelpSU for administrative users
    Given I am logged in as a user with the "administrator" role
    And I am on "admin"
    Then I should see the heading "Get Help" in the "Help" region
    And I should see "Problems using this service? Submit a HelpSU request." in the "Help" region
    When I click "HelpSU request"
    Then I should be on "https://helpsu.stanford.edu/helpsu/3.0/helpsu-form?pcat=sites"

  @api @live
  Scenario: Stanford Sites Backup and Migrate profile
    Given I am logged in as a user with the "administrator" role
    And the "backup_migrate" module is enabled
    And the cache has been cleared
    And I am on "admin/config/system/backup_migrate"
    Then I want to validate select field option "profile_id" default is "Stanford Sites Profile"
    When I go to "admin/config/system/backup_migrate/settings/profile"
    Then I should see "Stanford Sites Profile" in the "Content" region

  @api @live
  Scenario: AFS file storage checking
    Given I am logged in as a user with the "administrator" role
    And the "stanford_afs_quota" module is enabled
    And I am on "admin/reports/status"
    Then I should see "File Storage Limit"
    When I click "Check again" in the "File Storage Limit" row
    Then I should be on "admin/config/stanford-sites-helper/filequota/check"
    When I am on "admin/reports/status"
    And I click "request more storage" in the "File Storage Limit" row
    Then I should be on "https://helpsu.stanford.edu/helpsu/3.0/helpsu-form?pcat=sites"
