class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = 'Please log in'
      redirect_to new_session_path
    end
  end

  def require_logout
    if logged_in?
      flash[:alert] = 'Please log out'
      redirect_to tasks_path
    end
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = 'Only administrators can access'
      redirect_to tasks_path
    end
  end
end
