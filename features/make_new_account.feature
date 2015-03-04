Feature: Make New Account (Story 1)

    As a user
    So that I can make a new account
    I want to fill in my serial code and register my account with third party authentication


Scenario: login successful after entering correct serial code

    Given I am on the user login page
    When I fill in the correct serial code
    Then I should be on the offer page
    And I should see "Account Successfully Set Up"