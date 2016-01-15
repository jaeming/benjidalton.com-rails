class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]

  def index
    @portfolios = Portfolio.all
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
    @portfolio.save!
    redirect_to @portfolio, notice: 'Portfolio was successfully created.'
  end

  def update
    file = portfolio_params[:image]
    image = Portfolio.upload(file)
    @portfolio.update!(portfolio_params.except(:image).merge(image: image))
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
