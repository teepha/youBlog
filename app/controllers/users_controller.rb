class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]
  before_action -> { require_same_user(@user, root_path) }, only: [:edit, :update]
  before_action -> { require_admin(users_path) }, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 9)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to youBlog #{@user.username}"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Sorry, email already exists!"
      redirect_to signup_path
    end
  end

  def edit  
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Sorry, an error occured!"
      redirect_to user_path(@user)
    end
  end

  def show
    if @user
      @user_articles = @user.articles.paginate(page: params[:page], per_page: 6)
    else
      redirect_to users_path
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted!"
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :biography, :password)
    end

    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "Sorry, user not found!"
    end
end
