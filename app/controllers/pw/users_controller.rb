class Pw::UsersController < ApplicationController

  layout "pw"
  
  include GlobalHelper

  before_action :check_authorization
  
  before_action :find_user, only: [:index, :new, :edit, :update]
  before_action :get_users, only: [:index, :new, :edit]

  def index
  end

  def show
  	redirect_to pw_users_path
  end

  def edit
  	if @user.nil?
  		redirect_to pw_users_path
  		return
  	end

  	render "index"
  end

  def update
    @user.update(user_params)

    redirect_to edit_pw_user_path(@user.id)
  end

  def new
  	render "index"
  end

  def create
    @user = User.new(user_params)
    @user.company_id = logged_company_id

    if @user.save
      redirect_to edit_pw_user_path(@user.id)
      return
    end

    get_users
    render "index"
  end

  private

  def find_user
  	@user = User.new(:role => roles.keys[3], :company_id => logged_company_id)

    unless params[:id] == nil
      @user = User.find_by_id_and_company_id(params[:id], logged_company_id)
    end
  end

  def get_users
  	@users = User.where(:company_id => logged_company_id)
  end

  def user_params
    params.require(:user).permit(:company_id, :email, :new_password, :confirm_password, :first_name, :last_name, :role, :status)
  end

end
