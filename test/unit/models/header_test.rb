require File.join(File.dirname(__FILE__), '/../../test_helper')

class PersonTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert Person.create!
  end
  
end