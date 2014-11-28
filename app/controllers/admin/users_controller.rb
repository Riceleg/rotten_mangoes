class Admin::UsersController < ApplicationController

  before_action :admin_restrict

  def index
    @users = User.all.page(params[:page]).per(3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to movies_path, notice: "Welcom aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  protected

  def user_params
    params.require(:user).permit(:email, :first, :lastname, :password, :password_confirmation)
  end
  
end
