class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @questionnaires = @user.questionnaires.order(:created_at)
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_show_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :avatar, :avatar_cache)
  end

end
