require File.join(File.dirname(__FILE__), '/../../test_helper')

class PersonPhotoTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert PersonPhoto.create!
  end

end