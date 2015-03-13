Feature: Failure Authorization (Story 4)

    As a user
    So that I can re
    I want unregistered user to fail to access further

Scenario: login successful after entering correct serial code
	
	Given I am on the user login page
    Then I am signed in with "Facebook"
	And I am on the code entry page
    And I can see "Redeem your code"
	When I fill in "code" with "9283084"
	And I press "Submit" button
	Then I should be on the offer page