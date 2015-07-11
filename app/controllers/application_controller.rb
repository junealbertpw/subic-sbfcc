class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @posts = Post.latest_publish_with_limit(5)
  end

  def members
  	@business = Company.all.where(status: 1).order("member_type ASC")
  end

  def about
  end

  def blog
  end

end
