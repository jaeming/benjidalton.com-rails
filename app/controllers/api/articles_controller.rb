class Api::ArticlesController < ApplicationController

  def index
    @articles = Article.order("id DESC").all
    render json: @articles
  end

  def recent
    @articles = Article.order("id DESC").take(4)
    render json: @articles
  end

  def show
    @article = Article.find(params[:id])
    render json: @article
  end

  def create
    @article = Article.create(article_params)
    render json: @article
  end

  def update
    @article = Article.find(params[:id])
    @article.update!
    render json: @article
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    head :no_content
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

end
