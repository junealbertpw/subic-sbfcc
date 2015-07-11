class Pw::CategoriesController < ApplicationController

  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization
  before_action :super_and_admin_only
  before_action :get_categories, only: [:show, :new, :update, :create]

  def index
  	@categories = [] #Category.all
  end

  def show
  	@category = Category.find(params[:id])
  end

  def edit
  	redirect_to pw_category_path(:id => params[:id])
  end

  def update
  	render "show"
  end

  def new
  	@category = Category.new
  	@category.parent = "post"

  	render "show"
  end

  def create
  	@params = params[:category]
  	@category = Category.new

  	@category.name = @params[:name]
  	@category.description = @params[:description]
  	@category.parent = @params[:parent]

  	if @category.save
  		redirect_to pw_category_path(:id => @category.id)
  	end
  end

  def get_categories 
  	@categories = Category.all
  end

end
