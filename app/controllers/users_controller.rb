class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
  end
  
  def profile
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "プロフィール情報を変更しました"
      redirect_to users_profile_path
    else
      render "edit"
    end
  end
    
  private
  def user_params
    params.require(:user).permit(:avatar, :name, :introduction)
  end
end
