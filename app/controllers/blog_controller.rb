class BlogController < ApplicationController

  layout "application"

  before_action :get_post_categories
  before_action :check_category, :only => [:categorize, :show]

  def index
    @posts = Post.latest_publish_with_limit(10)
  end

  def categorize
    @posts = Post.select("posts.*, companies.id as company_id, companies.name as company_name")
                  .publish
                  .joins("left outer join companies on companies.user_id = posts.company_id")
                  .where(category_id: @category.id)
  end

  def show
    @post = Post.select("posts.*, companies.id as company_id, companies.name as company_name")
                .publish
                .joins("left outer join companies on companies.user_id = posts.company_id")
                .find_by(slug: params[:slug], category_id: @category.id )

    if @post.nil?
      redirect_to blog_path
      return
    end
  end

  def check_category
    categories = @categories.select{ |hash| hash[:slug] == params[:category] }

    if categories.empty?
      redirect_to blog_path 
      return
    end

    @category = categories.first;
  end

  def get_post_categories
  	@categories = Category.find_by_post
  end
  
end
