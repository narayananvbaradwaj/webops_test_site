require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "The WebOps Club"
    assert_equal full_title("Contact"), "Contact | The WebOps Club"
  end
end