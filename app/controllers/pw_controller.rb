class PwController < ApplicationController

  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization, :only => [:dashboard]

  def dashboard
    # session[:auth] = nil
    # render :json => session[:auth]
  end

  def login
  	@user = User.new

  	if !session[:auth].nil?
  		redirect_to pw_dashboard_path
  	end
  end

  def logout
    session[:auth] = nil
    redirect_to root_path
  end

  def authenticate
  	@auth = User.authenticate(params[:user])
  
  	if !@auth.nil?
      session[:auth] = @auth

  		redirect_to pw_dashboard_path
  		return
  	end

  	@user = User.new(user_params)
  	render "login"
  end

  private

  def user_params
  	params.require(:user).permit(:email)
  end

end
