class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]

  def index
    @portfolios = Portfolio.descending
  end

  def show
  end

  def new
    @portfolio = Portfolio.new
  end

  def edit
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    image_url = ImageUploadService.upload(portfolio_params[:image])
    @portfolio.image = image_url
    @portfolio.save!
    redirect_to @portfolio, notice: 'Portfolio was successfully created.'
  end

  def update
    image_url = ImageUploadService.upload(portfolio_params[:image]) || @portfolio.image
    @portfolio.update!(portfolio_params.except(:image).merge(image: image_url))
    redirect_to @portfolio, notice: 'Portfolio was successfully updated.'
  end

  def destroy
    @portfolio.destroy!
    redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.'
  end

  private

    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end


    def portfolio_params
      params.require(:portfolio).permit(:title, :description, :image, :link_to_src, :link_to_site)
    end

end
