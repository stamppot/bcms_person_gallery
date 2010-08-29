require "spec_helper"

describe "Person Type" do

  it "should have a unique name" do
    # Person Type should not be valid without a name
    person_type = PersonType.new
    person_type.should_not be_valid

    # Person Type should be valid once named
    person_type.name = 'Shawl'
    person_type.should be_valid
    person_type.save

    # A Person Type with the same name should not be valid
    person_type = PersonType.new :name => 'Shawl'
    person_type.should_not be_valid

    # When the name is changed it should be valid
    person_type.name = 'Rug'
    person_type.should be_valid
  end
end
