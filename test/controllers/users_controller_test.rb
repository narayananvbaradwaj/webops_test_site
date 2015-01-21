require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:Abhishek)
    @other_user = users(:test_user_1)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

#   test "should create user" do
#     assert_difference('User.count') do
#       post :create, user: { roll: @user.roll }
#     end

#     assert_redirected_to user_path(assigns(:user))
#   end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

#   test "should get edit" do
#     get :edit, id: @user
#     assert_response :success
#   end

#   test "should update user" do
#     patch :update, id: @user, user: { roll: @user.roll }
#     assert_redirected_to user_path(assigns(:user))
#   end

#   test "should destroy user" do
#     assert_difference('User.count', -1) do
#       delete :destroy, id: @user
#     end

#     assert_redirected_to users_path
#   end

  test "should redirect edit when not logged in" do
      get :edit, id: @user
      assert_not flash.empty?
      assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
      patch :update, id: @user, user: { roll: @user.roll }
      assert_not flash.empty?
      assert_redirected_to login_url
  end
  test "should redirect edit when logged in as wrong user" do
      log_in_as(@other_user)
      get :edit, id: @user
      assert flash.empty?
      assert_redirected_to root_url
  end
  test "should redirect update when logged in as wrong user" do
      log_in_as(@other_user)
      patch :update, id: @user, user: { roll: @user.roll }
      assert flash.empty?
      assert_redirected_to root_url
  end
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { password:              'password',
                                            password_confirmation: 'password',
                                            admin: true }
    assert_not @other_user.admin?
  end

  test "should add webops_skill" do
    log_in_as(@user)
    post :add_webops_skill, id: @user, skill: 'CSS'
    assert_not @user.reload.webops_skill.include?("CSS")
    assert @user.reload.webops_skill.include?("css")
    post :add_webops_skill, id: @user, skill: ''
    assert_not @user.reload.webops_skill.include?("")
  end

  test "should not add empty webops_skill" do
    log_in_as(@user)
    post :add_webops_skill, id: @user, skill: ''
    assert_not @user.reload.webops_skill.include?("")
  end
end