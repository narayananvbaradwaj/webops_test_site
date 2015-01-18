require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid register information" do
    get register_path
    assert_no_difference 'User.count' do
      post users_path, user: { roll:                  "mm12b37",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end

  test "valid register information" do
    get register_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { roll:                  "ff11f111",
                                            password:              "foobar",
                                            password_confirmation: "foobar" }
    end
    assert_template 'users/show'
  end
end