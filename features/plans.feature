Feature: Manage Plans
  In order to make plans
  I want to create and manage plans
  
  Scenario: Plans List

    Given a plan exists with name: "Gold", price: 12.99, billing_period: "monthly"
		And a plan exists with name: "Silver", price: 12.99, billing_period: "monthly"
    When I go to the plans page
    Then I should see "Gold"
    And I should see "Silver"


  Scenario: Create Plans
    Given I am on the new plan page
    And I fill in "Name" with "Gold"
		And I fill in "Price" with "12.99"
		And I press "Create"
		Then I should be on the plans page
		And I should see "Gold"
		
		
  Scenario: Edit Plan
    Given a plan exists with name: "Gold", price: 12.99, billing_period: "monthly"
		And I am on the plans page
		And I follow "Edit"
		And I fill in "Name" with "Platinum"
		And I press "Update"
		Then I should be on the plans page
		And I should see "Platinum"