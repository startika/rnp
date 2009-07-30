Feature: Comment podcast
  In order to do feedback
  As a podcast listener
  I want to comment podcast

  Scenario: Podcast landing page has comments on it
    Given I have podcast titled "Popular"
    And podcast titled "Popular" has following comments:
      | name         | url                      | body                   |
      | An anonymous | http://example.com       | not bad...             |
      | The Fan      | http://example.com       | you're best!           |
      | pleax        | http://twitter.com/pleax | you're still improving |
    When I go to the landing page of podcast titled "Popular"
    Then I should see "not bad..."
    And I should see "you're best!"
