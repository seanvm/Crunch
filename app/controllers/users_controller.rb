class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:show]
  before_action :correct_user,    only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
  
  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to root_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end