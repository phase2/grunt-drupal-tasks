Feature: CAPx Tamper
  In order to ensure that the capx module is installed and functional
  As an administrative user
  I want to ensure that the Stanford CAP Extensible module is working properly

  @api @dev @javascript @destructive
  Scenario: Stanford CAPx Mapper & Importer
    Given the "capx_tamper" module is enabled
    And I am authenticated with CAPx
    And I am logged in as a user with the "administrator" role
    # Update organization codes
    Then I am on "admin/config/capx/organizations/sync?destination=admin/config/capx/settings"
    And I wait for the batch job to finish
    And I should see "Organization codes have been updated."

    # Create a mapper
    Then I am on "admin/config/capx/mapper/new"
    And I fill in "title" with "Behat Tamper Map"
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
    And I should see "Behat Tamper Map"

    # Create an importer & import.
    Then I am on "admin/config/capx/importer/new"
    And I select "Behat Tamper Map" from "Mapping"
    And I fill in "Importer name" with "Behat Tamper Import"
    And I fill in "Organization(s)" with "BUWS"
    Then I press the "Save & Import Now" button
    And I wait for the batch job to finish
    And I should see "Behat Tamper Import"
    Then I click "Profiles" in the "Content" region
    And I should see the link "Stuart Broz"
    And I should see the link "Shea McKinney"

    # Tampers
    Then I click "Map"
    And I should see the link "Tampers"
    Then I am on "admin/config/capx/mapper/behat_tamper_map/tamper"
    And I should see the heading "Behat Tamper Map Tamper Plugins"
    And I should see "Title <- $.displayName"
    And I should see "First name <- $.names.legal.firstName"
    And I should see "Last Name <- $.names.legal.lastName"
    And I should see the link "Add Plugin"
    Then I click "Add Plugin"
    And I should see "The plugin to add"
    And I should see "Description"

    # Check each plugin
    Then I select "Unix timestamp to Date" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Date format"
    And I should see "A user-defined php date format string like \"m-d-Y H:i\""

    Then I select "String to Unix timestamp" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "This will take a string containing an English date format and convert it into a Unix Timestamp."

    Then I select "HTML entity decode" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Convert all HTML entities such as &amp; and &quot; to & and \"."

    Then I select "HTML entity encode" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "This will convert all HTML special characters such as > and & to &gt; and &apm;."

    Then I select "Make URLs absolute" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Make URLs in markup absolute. (i.e. <a href=\"/stuff/things\"> to <a href=\"http://example.com/stuff/things\">)."

    Then I select "Strip tags" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Allowed tags"

    Then I select "Explode" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "String separator"
    And I should see "Limit"

    Then I select "Filter empty items" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Filter out empty values from a list."

    Then I select "Implode" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "String glue"

    Then I select "Unique" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Makes the elements in a multivalued field unique."

    Then I select "Cast to integer" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "This plugin will convert any value to its integer form."
    And I should see ""

    Then I select "Format a number" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Decimals"
    And I should see "Decimal point"
    And I should see "Thousands separator"

    Then I select "Mathematical operation" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Operation"
    And I should see "Value"
    And I should see "Log"

    Then I select "Calculate hash" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Makes the value a hash of the values being imported. This allows for importing content that does not have a unique ID."
    And I should see "Override set value"

    Then I select "Copy source value" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "To or from"
    And I should see "Source"
    And I should see "$.displayName"

    Then I select "Country to ISO code" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Converts this field from a country name string to the two character ISO 3166-1 alpha-2 code."

    Then I select "Entity Field Query finder" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Entity type"
    Then I select "Node" from "Entity type"
    And I wait for AJAX to finish
    And I should see "Bundle"
    And I should see "Field"

    Then I select "Full U.S. state name to abbrev." from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Converts this field from a full state name name string to the two character abbreviation."

    Then I select "Rewrite" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Replacement pattern "
    And I should see "[$.displayName]"
    And I should see "[$.names.legal.firstName]"

    Then I select "Set value or default value" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "This field will be set to the value specified."
    And I should see "Only if empty"

    Then I select "Convert case" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "How to convert case "
    And I should see "UPPER CASE"

    Then I select "Convert to boolean" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Truth value"
    And I should see "False value"
    And I should see "If no match"

    Then I select "Find replace REGEX" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "REGEX to find"
    And I should see "Replacement pattern"
    And I should see "Limit number of replacements"

    Then I select "Format string" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see the link "sprintf"
    And I should see "Format"

    Then I select "Pad a string" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Pad length"
    And I should see "Pad string"
    And I should see "Pad type"

    Then I select "Trim" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Characters to trim "
    And I should see "Side"

    Then I select "Truncate" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Number of characters"
    And I should see "Ellipses"

    Then I select "URL Decode" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Decode method"

    Then I select "URL Encode" from "The plugin to add"
    And I wait for AJAX to finish
    And I should see "Configure URL Encode"

    Then I select "Find replace" from "The plugin to add"
    And I wait for AJAX to finish
    Then I should see "Text to find"
    And I should see "Text to replace"
    Then I fill in "Text to find" with "a"
    And I fill in "Text to replace" with "@"
    And I press the "Add" button
    Then I should see the link "Edit" in the "Content" region
    And I should see "Delete" in the "Content" region
    And the "Enabled" checkbox should be checked
    Then I am on "admin/config/capx/importer/edit/behat_tamper_import"
    And I press the "Save & Import Now" button
    And I wait for the batch job to finish
    Then I click "Profiles"
    And I should not see "Shea"
    And I should see "She@"

    # Delete the importer then the mapper.
    Then I am on "admin/config/capx/importer/delete/behat_tamper_import"
    And I select "Delete all of the items" from "profile_action"
    And I press the "Yes, please delete the importer" button
    Then I am on "admin/config/capx/mapper/delete/behat_tamper_map"
    And I press the "Yes, please delete" button
