Feature: Admin sign-in
  In order to get access to admin-restricted functionality
  As an admin
  I want to sign-in with access token

  Background:
    Given admin access token is set to "access-token"
    And I am on the auth page

  Scenario: Sing-in as admin
    When I fill in "Access Token" with "access-token"
    And I press "Auth!"

    Then I should be signed in admin session

  Scenario: Reject invalid access token
    When I fill in "Access Token" with "wrong-access-token"
    And I press "Auth!"

    Then I should be signed out of admin session
    And I should see "Wrong access token"
