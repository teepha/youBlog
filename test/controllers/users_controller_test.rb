require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    @user2 = User.create(username: "Mofe", email: "mofe@example.com", password: "password", admin: false)
  end

  test "should get users index" do
    get users_path
    assert_response :success
  end

  test "should get new user" do
    get signup_path
    assert_response :success
  end

  test "should get create user" do
    post "/users",
      params: { user: {username: "Shehu", email: @user.email,
                            password: "password", admin: false} }
    assert_response :success
  end

  test "should get show user" do
    sign_in_as(@user, "password")
    get user_path(@user)
    assert_response :success
  end

  test "should get update user" do
    sign_in_as(@user, "password")
    put "/users/#{@user.id}",
      params: { user: {username: "Shade"} }
    assert_redirected_to user_path(@user)
  end

  test "should get delete user" do
    sign_in_as(@user, "password")
    delete "/users/#{@user2.id}"
    assert_redirected_to users_path
  end
end
