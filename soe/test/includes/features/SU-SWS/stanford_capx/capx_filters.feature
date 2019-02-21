Feature: CAPx Filters
  In order to ensure that the capx module is installed and functional
  As an administrative user
  I want to ensure that the Stanford CAP Extensible module is working properly

  @api @dev @javascript @destructive
  Scenario: Stanford CAPx Filters
    Given the "capx_filters" module is enabled
    And I am authenticated with CAPx
    And I am logged in as a user with the "administrator" role

    # Update organization codes
    Then I am on "admin/config/capx/organizations/sync?destination=admin/config/capx/settings"
    And I wait for the batch job to finish
    And I should see "Organization codes have been updated."

    # Create a mapper
    Then I am on "admin/config/capx/mapper/new"
    And I fill in "title" with "Behat Filters Map"
    And I select "Node" from "entity-type"
    And I select "Person" from "bundle-node"
    And I click "Show node Properties"
    And I click "Show stanford_person Fields"
    And I fill in the following:
      | field-mapping[node-properties][title]                                        | $.displayName           |
      | field-mapping[node-stanford_person-fields][field_s_person_first_name][value] | $.names.legal.firstName |
      | field-mapping[node-stanford_person-fields][field_s_person_last_name][value]  | $.names.legal.lastName  |

    Then I press the "Save mapping" button
    And I should be on "admin/config/capx/mapper"
    And I should see "Behat Filters Map"

    # Create an importer & import.
    Then I am on "admin/config/capx/importer/new"
    And I select "Behat Filters Map" from "Mapping"
    And I fill in "Importer name" with "Behat Filters Import"
    And I fill in "Organization(s)" with "BUWS"
    Then I press the "Save & Import Now" button
    And I wait for the batch job to finish
    And I should see "Behat Filters Import"
    Then I click "Profiles" in the "Content" region
    And I should see the link "Stuart Broz"
    And I should see the link "Shea McKinney"

    # Create & Delete Filter
    Then I am on "admin/config/capx/importer/behat_filters_import/filters"
    And I should see the heading "Behat Filters Import Filters"
    And I should see "Remove existing on match"
    Then I click "+ Add New Filter"
    And I should see the heading "Add Filter to Behat Filters Import"
    And I should see "Data Browser"
    And I fill in "CAP API path" with "$.displayName"
    And I fill in "Value" with "test"
    And I select "=" from "Comparison operation"
    And I uncheck the box "Exclude content with this value"
    Then I press the "Save" button
    And I should be on "admin/config/capx/importer/behat_filters_import/filters"
    And I should see "$.displayName"
    And I should see "test"
    And I should see the link "Edit"
    And I should see the link "Delete"
    Then I click "Delete" in the "Content" region
    And I should see "Are you sure you wish to delete this filter?"
    And I should see the button "Cancel"
    Then I press the "Delete" button
    And I should not see "$.displayName"
    Then I check the box "Remove existing on match"
    And I press the "Save" button
    Then I should see "Settings Saved"
    And the "Remove existing on match" checkbox should be checked

    # Create the filter to filter out Shea
    Then I click "+ Add New Filter"
    And I fill in "CAP API path" with "$.displayName"
    And I fill in "Value" with "Shea"
    And I select "Contains" from "Comparison operation"
    And I check the box "Exclude content with this value"
    Then I press the "Save" button
    Then I am on "admin/config/capx/importer/edit/behat_filters_import"
    And I press the "Save & Import Now" button
    And I wait for the batch job to finish
    Then I click "Profiles"
    And I should not see "Shea"

    # Delete the importer then the mapper.
    Then I am on "admin/config/capx/importer/delete/behat_filters_import"
    And I select "Delete all of the items" from "profile_action"
    And I press the "Yes, please delete the importer" button
    Then I am on "admin/config/capx/mapper/delete/behat_filters_map"
    And I press the "Yes, please delete" button
