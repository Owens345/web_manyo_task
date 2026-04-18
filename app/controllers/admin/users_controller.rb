class Admin::UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
    @users = User.includes(:tasks).all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_user_params)
    if @user.save
      flash[:notice] = 'You have registered a user'
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(admin_user_params)
      flash[:notice] = 'Updated users'
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'You have deleted a user'
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
    end
    redirect_to admin_users_path
  end

  private

  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
