class Pw::CategoriesController < ApplicationController

  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization
  before_action :find_category, only: [:index, :new, :edit, :update]
  before_action :get_categories, only: [:index, :edit, :show]

  def index
  end

  def show
    redirect_to pw_categories_path
  end

  def edit
    if @category.nil?
      redirect_to pw_categories_path
      return
    end

    render "index"
  end

  def update
    @category.update(category_params)

    redirect_to pw_category_path(@category.id)
  end

  def new
    render "index"
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to edit_pw_category_path(@category.id)
      return
    end

    get_categories
    render "index"
  end

  private

  def find_category
    @category = Category.new(:parent => "post")

    unless params[:id] == nil
      @category = Category.find_by_id(params[:id])
    end
  end

  def get_categories
    @categories = Category.all
  end

  def category_params
    params.require(:category).permit(:parent, :name, :description)
  end

end
