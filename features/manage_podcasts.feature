Feature: Manage podcasts
  In order to fill up and manage portal content
  As a content manager
  I want to manage podcasts

  Scenario: Add new podcast
    When I go to the new podcast page
    And I fill in "Title" with "Brand New Podcast"
    And I fill in "Summary" with "This Week's Hot Topics"
    And I fill in "Asset Link" with "http://ruby.rpod.ru/some/path/rnpNN.mp3"
    And I press "Create"

    Then I should be on the podcasts list
    # And I should see flash "New podcast added"
    And I should see "Brand New Podcast"

  Scenario: Remove podcast
    Given I have exactly one podcast titled "Broken Podcast"
    And I am on the podcasts list

    When I click "Remove" link of podcast titled "Broken Podcast"

    Then I should be on the podcasts list
    And I should see no podcasts titled "Broken Podcast"
