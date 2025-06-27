class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [ :edit, :update, :destroy, :restore ]
  def index
    @users = User.active
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "user updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @user.soft_delete
    redirect_to admin_users_path, notice: "User Deleted"
  end

  def restore
    # @user = User.only_deleted.find(params[:id])
    @user.restore
    redirect_to admin_users_path, notice: "User is restored!"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_admin!
    redirect_to root_path unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_picture)
  end
end
