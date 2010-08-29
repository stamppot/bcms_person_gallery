require File.join(File.dirname(__FILE__), '/../../test_helper')

class PersonTypeTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert PersonType.create!
  end
  
end