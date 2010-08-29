Feature: Manage Person Types
	In order to record information about persons
	As a product administrator
	I Want to create new product types, edit existing product types, delete product types and view all product types

	Background:
		Given I am logged in as "cmsadmin" with password "cmsadmin"

	Scenario: Create Person Type
	    Given I have no product types
	    And I am on the list of product types
	    When I follow "ADD NEW CONTENT"
	    And I fill in "Name" with "Shawl"
	    And I fill in "Danish Name" with "Chalina"
	    And I fill in "Low Stock Level" with "5"
	    And I fill in "Description" with "Awesome quality."
	    And I press "person_type_submit"
	    Then I should see "Person Type 'Shawl' was created"
	    And I should see "Shawl"
	    And I should see "Chalina"
	    And I should see "5"
	    And I should see "Awesome quality."
	    And I should have 1 product type

	Scenario: Show only users belonging a group of type "CMS User" in the Primary Stock User listbox
		Given the following user records
			| first_name | groups                                     |
			| No Group   |                                            |
			| Guest      | Guest                                      |
			| Admin User | Cms Administrators                         |
			| Editor     | Content Editors                            |
			| All Groups | Guest, Cms Administrators, Content Editors |
		And I am on the list of product types
		When I follow "ADD NEW CONTENT"
		Then I should not see "No Group" within "#person_type_user_id"
		And I should not see "Guest" within "#person_type_user_id"
		And I should see "Admin User" within "#person_type_user_id"
		And I should see "Editor" within "#person_type_user_id"
		And I should see "All Groups" within "#person_type_user_id"
