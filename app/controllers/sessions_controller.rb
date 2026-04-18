class SessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'I have logged in'
      redirect_to tasks_path
    else
      flash.now[:alert] = 'Your email address or password is incorrect'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'logged out'
    redirect_to new_session_path
  end
end
