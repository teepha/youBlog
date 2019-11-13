require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test "should get new login" do
    get login_path
    assert_response :success
  end

  test "should get login" do
    sign_in_as(@user, "password")
    assert_response :redirect
    follow_redirect!
  end

  test "should get delete article" do
    sign_in_as(@user, "password")
    delete "/users/#{@user.id}"
    assert_redirected_to users_path
  end
end
