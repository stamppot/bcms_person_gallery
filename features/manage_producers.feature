Feature: Manage Producers
	In order to sell persons
	As a product administrator
	I Want to manage producers

	Background:
		Given I am logged in as "cmsadmin" with password "cmsadmin"

	Scenario: Producers List
		Given I have producers named Joe and Jane
		When I go to the list of producers
		Then I should see "Joe"
		And I should see "Jane"

	Scenario: Create Producer
	    Given I have no producers
	    And I am on the list of producers
	    When I follow "ADD NEW CONTENT"
	    And I fill in "Name" with "Joe"
	    And I fill in "Last Name" with "Bloggs"
	    And I fill in "Description" with "The unknown producer."
	    And I press "producer_submit"
	    Then I should see "Producer 'Joe' was created"
	    And I should see "Joe"
	    And I should see "Bloggs"
	    And I should see "The unknown producer."
	    And I should see "draft"
	    And I should have 1 producer
