class Pw::MembersController < ApplicationController
  
  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization
  before_action :member_types, :only => [:show, :new, :edit]

  def index
    @users = User.select("users.id as user_id, first_name, last_name, users.email, companies.*").joins(:company)
  end

  def show
    redirect_to edit_pw_member_path(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to edit_pw_member_path(params[:id])
    end
  end

  def new
    @user = User.new
    @company = @user.build_company

    @user.company.status = Company.statuses.first[0]
  end

  def create
    @user = User.new(user_params)
    
    if !@user.save
      return
    end

    @user.company_id = @user.company.id
    @user.save

    redirect_to edit_pw_member_path(@user.id)
  end

  private

  def member_types
    @member_types = Company.member_types
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :position, :new_password, :user_type, :status,
                                  company_attributes:[:id, :name, :website, :phone, :fax, :email, :address, :description, 
                                                      :cover, :member_type, :status])
  end

end