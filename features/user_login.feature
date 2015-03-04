Feature: User Login (Story 2)

	As a user
	So that I can log in to my account
	I want to be able to login to my existing account with a third party authentication to see my offers

Scenario: successful login after entering valid credentials

	Given I am on the user login page
	When I enter my credentials
	Then I should be on the offer page
	And I should see "Login Successful"