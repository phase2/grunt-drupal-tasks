Feature: Stanford Jumpstart
  In order to ensure that functionality of the module
  As an administrative user
  I want to ensure that Pages and permissions exist.
  Also as a simple user role
  I wan to ensure some form fields are hidden and permissions are denied.

  @api @safe
  Scenario: Check if pages exist. Each product might have different contents on the page.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart"
    Then I should see "Jumpstart Help"
    Then I should see the link "Get Help" in the "Branding" region
    Then I should see the link "Add Features" in the "Branding" region
    Then I should see the link "Launch Checklist" in the "Branding" region
    Then I should see the heading "Get Help" in the "Help" region

  @api @safe
  Scenario: Check if permissions exist.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/people/permissions"
    Then I should see "Administer Jumpstart Help"
    And I should see "Administer Jumpstart Help"
    And I should see "Access Jumpstart Features"
    And I should see "Assign Administrator Role"
    And I should see "Use Full Block Interface"


  @api @safe
  Scenario: Check permissions function correctly
    Given I run drush "rcrt" "Behat"
    And I run drush "rap" "Behat 'access administration menu, administer permissions, administer users, administer site configuration, administer beans, administer blocks, view bean page, create stanford_page content, view the administration theme, administer nodes'"
    And I am logged in as a user with the "Behat" role
    And I am on "admin/structure/block"
    Then I should see "Access Denied"
    # Stanford Page.
    And I am on "node/add/stanford-page"
    Then I should see "Create Stanford Page"
    And I should not see "Promoted to front page"
    And I should not see "Sticky at top of lists"
    # Block Form.
    Then I am on "admin/structure/block/manage/system/help/configure"
    And I should see "Block title"
    And I should not see "Region Settings"
    And I should not see "Content types"
    # Bean Edit Form.
    And I am on "block/add/stanford-banner"
    Then I fill in "label" with "Banner Test"
    And I press the "Save" button
    And I click "Edit Block"
    Then I should not see "Create new revision"
    And I should not see "Set Revision as default"
    # Add permissions
    Then I run drush "rap" "Behat 'jumpstart use full block'"
    And I reload the page
    Then I should see "Create new revision"
    And I should see "Set Revision as default"
    # Back to block configure form.
    Then I am on "admin/structure/block/manage/system/help/configure"
    Then I should see "Region Settings"
    And I should see "Content types"
    # Back to stanford page node form.
    Then I am on "node/add/stanford-page"
    And I should see "Promoted to front page"
    And I should see "Sticky at top of lists"
    # Permissions page is denied.
    Then I am on "admin/people/permissions"
    And I should see "Access Denied"
    # Can't add/remove administrator role.
    Then I am on "admin/people"
    And I check the box "views_bulk_operations[0]"
    And I select "Change user roles" from "operation"
    And I press the "Execute" button
    Then I should see "Add roles"
    And I should not see "administrator"
    # Site Configuration Page.
    Then I am on "admin/config/system/site-information"
    And I should not see "Default front page"
    # User edit page.
    Then I am on "user"
    And I click "Edit"
    Then I should not see "administrator"
    Then I run drush "rap" "Behat 'jumpstart assign administrator role'"
    And I reload the page
    And I should see "administrator"
    # Kill the role
    Then I run drush "rdel" "Behat"
