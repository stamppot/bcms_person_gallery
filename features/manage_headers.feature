Feature: Manage Producers
	In order to sell persons
	As a product administrator
	I Want to manage persons

	Background:
		Given I am logged in as "cmsadmin" with password "cmsadmin"

	Scenario: Create Producer
	    Given I have no producers
	    And I have producers named Billy and Jane
	    And I have product types named Shawl and Runner
	    And I have wool types named Sheep and Alpaca
	    And I am on the list of persons
	    When I follow "ADD NEW CONTENT"
	    And I fill in "Item Number" with "001"
	    And I select "Billy" from "Producer"
	    And I select "Shawl" from "Person type"
	    And I select "Sheep" from "Wool type"
	    And I fill in "Purchase price usd" with "45.12"
	    And I fill in "Purchase price bob" with "94.63"
	    And I fill in "Selling price" with "105.43"
	    And I fill in "Summary Description" with "Summary of it."
	    And I fill in "Description" with "Really nice product."
	    And I press "product_submit"
	    Then I should see "Person '001' was created"
	    And I should see "001"
	    And I should see "Billy"
	    And I should see "Shawl"
	    And I should see "Sheep"
	    And I should see "45.12"
	    And I should see "94.63"
	    And I should see "105.43"
	    And I should see "Summary of it."
	    And I should see "Really nice product."
	    And I should see "draft"
	    And I should have 1 product
