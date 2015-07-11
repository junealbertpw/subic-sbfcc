class Pw::ArticlesController < ApplicationController
  
  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization
  
  def index
    if display_on_super_and_admin
      @articles = Article.all.order('id desc')
    else
      @articles = Article.all.where(:company_id => logged_company_id).order('id desc')
    end
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

    # render :json => params[:article]
    # return

    # @params = params[:article]

    # @article = Article.create do |p|
    #   p.title = @params[:title]
    #   p.content = @params[:content]
    #   p.tags = @params[:tags]
    #   p.status = @params[:status]
    # end

    # if @article.save
    #   redirect_to edit_pw_article_path(:id => @article.id, :change => 0)
    # end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :tags, :status, :cover, :category_id)
  end

end
