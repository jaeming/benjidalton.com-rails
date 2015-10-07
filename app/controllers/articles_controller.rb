class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.friendly.find(params[:id])
  end

  def update
    @article = Article.friendly.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.friendly.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def show
    @article = Article.friendly.find(params[:id])
  end

  def index
    @articles = Article.order("id DESC").all
    @article_months = Article.all.group_by { |post| post.created_at.beginning_of_month}
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

end
