class StocksController < ApplicationController
  include UsersHelper

  def index
    @port_id = stock_params[1]
    if user?
      @user = params[:user_id]
      @stocks = current_user.stocks
    else
      @user = nil
      @port_id = stock_params[1]
      @stocks = current_user.portfolios.find(params[:portfolio_id]).port_stocks.order_by_shares
      @user_stocks = current_user.stocks
      @amount = dividend_amount(@stocks)
    end
  end

  def create
    ticker = stock_params[0].upcase
    create_stock(ticker)
  end

  def destroy
    stock = current_user.stocks.find(params[:id])
    stock.destroy
    redirect_to user_stocks_path(current_user)
  end

  private
  def user?
    if params[:user_id]
      return true
    end
    return false
  end

  def dividend_amount(stocks)
    amount = 0
    stocks.each do |s|
      stock = Stock.find(s.stock_id)
      amount += stock.dividend_per_share.to_f * s.shares
    end
    return amount
  end


  def create_stock(ticker)
    stock_info = Api.get_info(ticker)
    if !current_user.stocks.any? {|x| x.symbol == ticker} && !stock_info.empty?
      stock = Stock.create(:symbol => stock_info['Symbol'], :name => stock_info["Name"], :description => stock_info["Description"], :dividend_per_share => stock_info["DividendPerShare"], :dividend_date => stock_info["DividendDate"], :user_id => current_user.id)
      redirect_to user_stocks_path(current_user)
    else
      # Print Error
      flash[:notice] = "Error: Stock already exists or ticker is invalid"
      redirect_to user_stocks_path(current_user)
    end
  end

  def stock_params
    params.values_at(:ticker, :portfolio_id)
  end
end
