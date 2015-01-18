require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", full_title()
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", full_title('About')
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", full_title('Contact')
  end

  test "should get resource" do
    get :resource
    assert_response :success
    assert_select "title", full_title('Resource')
  end

end
