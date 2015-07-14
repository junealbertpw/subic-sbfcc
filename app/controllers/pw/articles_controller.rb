class Pw::ArticlesController < ApplicationController
  
  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization
  
  def index
    @articles = Article.by_company_id(logged_company_id)
  end

  def show
    redirect_to edit_pw_article_path(:id => params[:id])
  end

  def edit
  	@article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.published_by = logged_user_id
    
    @article.update(article_params)

    redirect_to edit_pw_article_path(:id => @article.id, :change => 1)
  end

  def new
    @article = Article.new
    @article.status = "draft"
  end

  def create
    @article = Article.new(article_params)
    @article.company_id = logged_company_id
    @article.published_by = logged_user_id

    if @article.save
      redirect_to edit_pw_article_path(:id => @article.id, :change => 0)
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :tags, :status, :cover, :category_id)
  end

end
