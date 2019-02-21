Feature: Stanford CAPx
  In order to ensure that the capx module is installed and functional
  As an administrative user
  I want to ensure that I can create a mapper & and importer and import profiles.

  @api @dev @javascript @destructive
  Scenario: Stanford CAPx Mapper & Importer
    Given the "stanford_capx" module is enabled
    And I am authenticated with CAPx
    And the "stanford_capx" module is enabled
    And I am logged in as a user with the "administrator" role
    And I am on "admin/config/capx"

    # Check various pages/links.
    When I click "Map"
    Then I should be on "admin/config/capx/mapper"
    And I should see "After you have connected to CAP, create a Mapping to link CAP’s fields with your fields."
    When I click "Create new mapping"
    Then I should be on "admin/config/capx/mapper/new"
    And I should see "Mapping title"
    And I should see "Entity mapping"
    And I should see "Field mapping"
    And I should see "Data browser"
    When I click "Import"
    Then I should be on "admin/config/capx/importer"
    And I should see "After you have Mapping configured, create an Importer to chose which profiles you would like to import."
    When I click "Create new importer"
    Then I should be on "admin/config/capx/importer/new"
    And I should see "Configuration"
    And I should see "Automatic synchronization options (CRON)"
    And I should see "Add groups and individuals"
    When I click "Help"
    Then I should be on "admin/config/capx/help"
    And I should see "Getting started"
    And I should see "CAP data - Choosing fields"
    And I should see "Resources for developers"
    And I should see "Authentication credentials"
    When I click "Settings" in the "Content" region
    Then I should be on "admin/config/capx/settings"
    And I should see the link "Authorization" in the "Content" region
    And I should see the link "Advanced" in the "Content" region
    And I should see the link "Synchronization settings" in the "Content" region
    And I should see the link "Organizations & Schema" in the "Content" region

    # Update organization codes
    Then I am on "admin/config/capx/organizations/sync?destination=admin/config/capx/settings"
    And I wait for the batch job to finish

    # Create a mapper
    Then I am on "admin/config/capx/mapper/new"
    Then I fill in "title" with "CAPx Mapper"
    And I select "Node" from "entity-type"
    And I select "Person" from "bundle-node"
    Then I click "Show node Properties"
    Then I click "Show stanford_person Fields"
    And I fill in the following:
    | field-mapping[node-properties][title]                                        | $.displayName           |
    | field-mapping[node-stanford_person-fields][field_s_person_first_name][value] | $.names.legal.firstName |
    | field-mapping[node-stanford_person-fields][field_s_person_last_name][value]  | $.names.legal.lastName  |

    Then I press the "Save mapping" button
    And I should be on "admin/config/capx/mapper"
    And I should see "CAPx Mapper"

    # Create an importer & import.
    Then I am on "admin/config/capx/importer/new"
    And I select "CAPx Mapper" from "Mapping"
    And I fill in "Importer name" with "CAPx Importer"
    And I fill in "Organization(s)" with "BUWS"
    Then I press the "Save & Import Now" button
    And I wait for the batch job to finish
    And I should see "Sync successfully completed"
    Then I click "Update profiles now"
    And I wait for the batch job to finish
    And I should see "Sync successfully completed."

    # Check Profiles Page
    Then I click "Profiles" in the "Content" region
    And I should be on "admin/config/capx/profiles"
    And I should see 1 or more ".views-field-title" elements
    Then I click "Edit" in the "Content" region
    And I should see "This entity has been imported from the CAP API."
    And I should see "CAPx Information"
    And I should see the link "Update this profile from CAP"
    And I should see the link "Disable automatic updates from CAP for this profile"

    # Delete the importer then the mapper.
    Then I am on "admin/config/capx/importer/delete/capx_importer"
    And I select "Delete all of the items" from "profile_action"
    And I press the "Yes, please delete the importer" button
    Then I am on "admin/config/capx/mapper/delete/capx_mapper"
    And I press the "Yes, please delete" button
