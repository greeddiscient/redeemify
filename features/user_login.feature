Feature: User Login (Story 2)

	As a user
	So that I can log in to my account
	I want to be able to login to my existing account with a third party authentication to see my offers

Scenario: successful login after entering valid credentials
	
	Given I am on the user login page
	And I have already registered with "Facebook"
    Then I am signed in with "Facebook"
	Then I can see "Offer page"