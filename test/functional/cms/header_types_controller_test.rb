require File.join(File.dirname(__FILE__), '/../../test_helper')

class Cms::PersonTypesControllerTest < ActionController::TestCase

  def setup
    login_as_cms_admin
  end

end