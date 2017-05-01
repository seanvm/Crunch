class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :initialize_omniauth_state
  before_action :current_user
  helper_method :current_user
  before_action :current_date

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_date
    date = Time.now.strftime("%m/%d/%Y")
    @current_date = Date.strptime(date, "%m/%d/%Y")
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to root_url
    end
  end

  protected

  def initialize_omniauth_state
    session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end

