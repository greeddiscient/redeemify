Feature: Redeem Code (Story 3)

	As a user
	So that I can redeem my code
	I want to see the expiry date and instructions on how to redeem the code

Scenario: view vendor code details after clicking details button

	Given I am on the offer page
	When I click the "Details" button
	I should see the vendor code
	And I should see the expiration date
	And I should see the instructions