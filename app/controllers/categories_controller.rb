class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:update, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 12)
  end

  def create
    @category = Category.new(name: params[:name])
    if @category.save
      flash[:success] = "New category was created successfully."
      redirect_to categories_path
    else
      flash[:error] = "Sorry, an error occured!"
    end
  end

  def update
    if  @category.update(params.require(:category).permit(:name))
      flash[:success] = "Category name was successfully updated :)"
      redirect_to category_path(@category)
    else
      flash[:error] = "Sorry, an error occured!"
    end
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 8)
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Only admins can perform this action!"
      redirect_to categories_path
    end
  end
end
