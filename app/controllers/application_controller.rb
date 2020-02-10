class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    if !logged_in?
      flash[:danger] = "Please login to perform this action!"
      redirect_to root_path
    end
  end

  def require_same_user(user, path)
    if current_user != user && !current_user.admin?
      flash[:danger] = "Sorry, you are not authorized to perform this action!"
      redirect_to path
    end 
  end

  def require_admin(path)
    if !current_user.admin?
      flash[:danger] = "Sorry, you are not authorized to perform this action!"
      redirect_to path
    end
  end
end
