Feature: Vendor Login (Story 4)

	As a provider/vendor
	So that I can login to resend the codes
	I want to login using my account and see a page with an upload form

Scenario: successful login after entering valid credentials

	Given I am on the vendor login page
	When I enter my credentials
	Then I should be on the offer page
	And I should see "Login Successful"