Feature: CAPX Auto Node Title Support
  In order to ensure that the capx module is installed and functional
  As an administrative user
  I want to ensure that the Stanford CAP Extensible module is working properly

  @api @dev @destructive
  Scenario: Stanford CAP Auto Node Title
    Given the "capx_auto_nodetitle" module is enabled
    And I am logged in as a user with the "administrator" role
    Then I am on "admin/config/capx/mapper/new"

    Then I select "Node" from "entity-type"
    And I select "Person" from "bundle-node"
    And I fill in the following:
      | title                                                                        | CAPx Auto Nodetitle Mapper |
      | Machine name                                                                 | capx_auto_nodetitle_mapper |
      | field-mapping[node-stanford_person-fields][field_s_person_first_name][value] | $.names.legal.firstName    |
      | field-mapping[node-stanford_person-fields][field_s_person_last_name][value]  | $.names.legal.lastName     |

    Then I press the "Save mapping" button
    And I should be on "admin/config/capx/mapper"
    And I should see "CAPx Auto Nodetitle Mapper"

    Then I am on "admin/config/capx/mapper/delete/capx_auto_nodetitle_mapper"
    And I press the "Yes, please delete" button
    # Travis hangs at the end for some unknown reason. The homepage step is silly, but prevents the hang.
    When I am on the homepage

