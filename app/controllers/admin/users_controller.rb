class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [ :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def new
  end
  def create
  end

  def edit
    
  end

  def update
  end

  def destroy
    if current_user.admin?
      @user.destroy
      redirect_to admin_dashboard_path, notice: "User Deleted"
    else
      redirect_to admin_users_path, alert: "Not authorized"
    end
  end
  private

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_admin!
    redirect_to root_path unless current_user.admin? 
  end

end
