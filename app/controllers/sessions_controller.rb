class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    log_in @user
    redirect_back_or @user
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end