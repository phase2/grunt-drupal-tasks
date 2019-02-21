Feature: Stanford SoE Helper Collection modules
  In order to ensure the Stanford SoE Helper Collection modules
   are enabled.
  As an administrator
  I want to be able to view the modules for magazines as enabled

  @api @safe
  Scenario: Verify Collection modules are enabled
    Given I am logged in as a user with the "administrator" role
    And I am on "/admin/modules"
    Then I should see "Modules"
    And I should see "op"
    And I should see "List"
    Then I should see 1 "#edit-modules-stanford-stanford-soe-helper-collection-enable" element
    And the "modules[Stanford][stanford_soe_helper_collection][enable]" checkbox should be checked

    Then I should see 1 "#edit-modules-stanford-stanford-soe-helper-collection-administration-enable" element
    And the "modules[Stanford][stanford_soe_helper_collection_administration][enable]" checkbox should be checked

    Then I should see 1 "#edit-modules-stanford-stanford-soe-helper-collection-layouts-enable" element
    And the "modules[Stanford][stanford_soe_helper_collection_layouts][enable]" checkbox should be checked

    Then I should see 1 "#edit-modules-stanford-stanford-soe-helper-collection-views-enable" element
    And the "modules[Stanford][stanford_soe_helper_collection_views][enable]" checkbox should be checked
