class Pw::UsersController < ApplicationController

  layout "pw"

  before_action :get_users, only: [:index]

  def index
  	@user = User.new
  	@user.role = User.roles.keys[3]
  end

  def edit
  end

  def update
  end

  def create
  end

  def get_users
  	@users = User.select("users.*, companies.name AS company_name, companies.id AS company_id")
  					.joins("LEFT OUTER JOIN companies on companies.user_id = users.company_id")
  end

end
