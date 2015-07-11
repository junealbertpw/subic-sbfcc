class Pw::PostsController < ApplicationController
  
  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization
  before_action :get_post_categories#, only: [:new, :edit, :update, :create]

  def index
    @hash = {}
    @posts = []

    if display_on_super_and_admin
      @posts = Post.all.order('id desc')
    else
      @posts = Post.all.where(:company_id => logged_company_id).order('id desc')
    end

    @categories.each do |category|
      @hash[category.id] = category.name
    end
  end

  def show
    redirect_to edit_pw_post_path(:id => params[:id])
  end

  def edit 
  	@post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.published_by = logged_user_id
    
    @post.update(post_params)

    redirect_to edit_pw_post_path(:id => @post.id, :change => 1)
  end

  def new
    @post = Post.new
    @post.status = "draft"
  end

  def create
    @post = Post.new(post_params)
    @post.company_id = logged_company_id
    @post.published_by = logged_user_id

    if @post.save
      redirect_to edit_pw_post_path(:id => @post.id, :change => 0)
    end
  end

  def get_post_categories
    @categories = Category.post
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :tags, :status, :cover, :category_id)
  end

end
