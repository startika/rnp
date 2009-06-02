Feature: Podcasts list
  In order to be tuned
  As a podcast listener
  I want to see the podcasts list

  Scenario: Podcasts list
    Given I have podcast titled "Pilot Release"
    And I have podcast titled "Second One"
    And I have podcast titled "Third as Expected"

    When I go to the podcasts list

    Then I should see "Pilot Release"
    And I should see "Second One"
    And I should see "Third as Expected"

  Scenario: Podcasts list null screen
    Given I have no podcasts
    When I go to the podcasts list
    Then I should see nice podcasts list null screen

  Scenario: Podcasts should be numbered
    Given I have a couple of podcasts
    When I go to the podcasts list
    Then I should see podcasts are numbered
