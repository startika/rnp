Feature: Podcast landing page
  In order to get additional info
  As a podcast listener
  I want to see podcast landing page

  Scenario: Podcast title on podcasts list leads to podcast landing page
    Given I have podcast titled "Pilot Release"
    And I am on the podcasts list
    When I click on the title of podcast titled "Pilot Release"
    Then I should be on the landing page of podcast titled "Pilot Release"
