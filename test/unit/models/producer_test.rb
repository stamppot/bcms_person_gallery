require File.join(File.dirname(__FILE__), '/../../test_helper')

class ProducerTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert Producer.create!
  end
  
end