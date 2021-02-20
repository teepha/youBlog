class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_login, except: [:index, :show]
  before_action -> { require_same_user(@article.user, articles_path) }, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 8).order('created_at DESC')
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      flash[:success] = "Article was successfully created!"
      redirect_to article_path(@article)
    else
      flash[:danger] = "#{@article.errors.full_messages[0]}"
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated!"
      redirect_to article_path(@article)
    else
      flash[:danger] = "#{@article.errors.full_messages[0]}"
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted!"
    redirect_to articles_path
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
    end
end
