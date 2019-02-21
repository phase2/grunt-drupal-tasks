Feature: Magazine modules
  In order to ensure the Magazine modules are enabled
  As an administrator
  I want to be able to view the modules for magazines as enabled

  @api @safe
  Scenario: Verify Magazine modules are enabled
    Given I am logged in as a user with the "administrator" role
    And I am on "/admin/modules"
    Then I should see "Modules"
    And I should see "op"
    And I should see "List"
    Then I should see 1 "#edit-modules-stanford-stanford-magazine-issue-administration-enable" element
    And the "modules[Stanford][stanford_magazine_issue_administration][enable]" checkbox should be checked
    Then I should see 1 "#edit-modules-stanford-stanford-magazine-issue-enable" element
    And the "modules[Stanford][stanford_magazine_issue][enable]" checkbox should be checked
    Then I should see 1 "#edit-modules-stanford-stanford-magazine-article-views-enable" element
    And the "modules[Stanford][stanford_magazine_article_views][enable]" checkbox should be checked
    Then I should see 1 "#edit-modules-stanford-stanford-magazine-article-administration-enable" element
    And the "modules[Stanford][stanford_magazine_article_administration][enable]" checkbox should be checked
    Then I should see 1 "#edit-modules-stanford-stanford-magazine-enable" element
    And the "modules[Stanford][stanford_magazine][enable]" checkbox should be checked
