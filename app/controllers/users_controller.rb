class UsersController < ApplicationController

  def index
    @user = User.find_by(name: params[:user][:name])
    return head(:forbidden) unless @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
  end

  def create
    @user = User.create(user_params)
    if @user.password != @user.password_confirmation
      redirect_to '/users/new'
    else
      session[:user_id] = @user.id
      redirect_to '/'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
