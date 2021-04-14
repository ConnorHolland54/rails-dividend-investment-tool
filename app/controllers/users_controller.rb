class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to portfolios_path
    else
      # Flash Error
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
