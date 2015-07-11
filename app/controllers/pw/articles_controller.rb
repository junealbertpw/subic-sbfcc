class Pw::ArticlesController < ApplicationController
  
  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization
  
  def index
    @articles = Article.all.order('id desc')
  end

  def show
    redirect_to edit_pw_article_path(:id => params[:id])
  end

  def edit
  	@article = Article.find(params[:id])
  end

  def update
    @params = params[:article]
    @article = Article.find(params[:id])

    @article.title = @params[:title]
    @article.content = @params[:content]
    @article.tags = @params[:tags]
    @article.status = @params[:status]

    @article.save

  	redirect_to edit_pw_article_path(:id => params[:id], :change => 1)
  end

  def new
    @article = Article.new
    @article.status = "draft"
  end

  def create
    @params = params[:article]

    @article = Article.create do |p|
      p.title = @params[:title]
      p.content = @params[:content]
      p.tags = @params[:tags]
      p.status = @params[:status]
    end

    if @article.save
      redirect_to edit_pw_article_path(:id => @article.id, :change => 0)
    end
  end

end
