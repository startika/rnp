Feature: Access restriction
  In order to prevent unauthorized content modifications
  As a resource owner
  I want to restrict access to sensitive areas

  Scenario: Display podcast's manage controls for admin
    Given I have a couple of podcasts
    And I signed in admin session
    When I go to the podcasts list
    Then I should see podcast controls

  Scenario: Hide podcast's manage controls for unauthorized user
    Given I have a couple of podcasts
    And I signed out of admin session
    When I go to the podcasts list
    Then I should not see podcast controls

  Scenario: Add podcast restrictions
    Given I signed out of admin session

    When I go to the new podcast page
    Then I should see "Access to this area is restricted"

    When I'm creating podcast with title "Unauthorized"
    Then I should see "Access to this area is restricted"

  Scenario: Edit podcast restrictions
    Given I have exactly one podcast titled "Something Interesting"
    And I signed out of admin session

    When I go to edit page of podcast titled "Something Interesting"
    Then I should see "Access to this area is restricted"

    When I'm updating podcast titled "Something Interesting" with title "Unauthorized"
    Then I should see "Access to this area is restricted"

  Scenario: Remove podcast restrictions
    Given I have exactly one podcast titled "Something Interesting"
    And I signed out of admin session
    When I'm deleting podcast titled "Something Interesting"
    Then I should see "Access to this area is restricted"
