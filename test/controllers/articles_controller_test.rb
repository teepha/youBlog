require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "tests")
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    @article = @user.articles.create(title: "Shade corner", 
                              description: "We were able to successfully test a very small workflow.",
                              category_ids: [@category.id])
  end

  test "should get articles index" do
    get articles_path
    assert_response :success
  end

  test "should get new article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_response :success
  end

  test "should get create article" do
    sign_in_as(@user, "password")
    post "/articles",
      params: { article: {title: "Shade corner", 
                    description: "We were able to successfully test a very small workflow.",
                    category_ids: [@category.id]} }
    assert_response :redirect
  end

  test "should get show article" do
    # get "/articles/#{@article.id}"
    get article_path(@article)
    assert_response :success
  end
  
  test "should get edit article" do
    sign_in_as(@user, "password")
    get edit_article_path(@article)
    assert_response :success
  end
  
  test "should get update article" do
    sign_in_as(@user, "password")
    put "/articles/#{@article.id}",
      params: { article: {title: "Shade corner season 1"} }
    assert_response :redirect
    follow_redirect!
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference 'Article.count' do
      delete article_path(@article), params: { article: {title: "Shade corner"} }
    end
    assert_redirected_to root_path
  end

  test "should get delete article" do
    sign_in_as(@user, "password")
    delete "/articles/#{@article.id}"
    assert_response :redirect
    follow_redirect!
  end
end
