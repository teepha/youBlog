require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test "should get categories index" do
    get categories_path
    assert_response :success
  end

  test "should get create" do
    sign_in_as(@user, "password")
    post categories_path
    assert_response :success
  end

  test "should get show" do
    get category_path(@category)
    assert_response :success
  end

  test "should get update" do
    sign_in_as(@user, "password")
    put "/categories/#{@category.id}",
      params: { category: {name: "shoes"} }
    assert_response :redirect
    follow_redirect!
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: "sports"} }
    end
    assert_redirected_to categories_path
  end
end
