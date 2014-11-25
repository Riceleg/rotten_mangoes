class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user.params)

    if @user.save
      redirect_to movies_path
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :first, :lastname, :password, :password_confirmation)
  end
end
