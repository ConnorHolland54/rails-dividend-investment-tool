class StocksController < ApplicationController
  include UsersHelper

  def new
    @port_id = params[:portfolio_id]
  end

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
    if !ticker.empty?
      if stock_params[1]
        add_to_list_then_portfolio(ticker, stock_params[1])
        redirect_to portfolio_stocks_path(stock_params[1])
      else
        create_stock(ticker, 1)
        redirect_to user_stocks(current_user)
      end
    else
      # error
    end
  end

  def destroy
    stock = current_user.stocks.find(params[:id])
    stock.destroy
    redirect_to user_stocks_path(current_user)
  end

  private

  def add_to_list_then_portfolio(ticker, port_id)
    create_stock(ticker, 2)
    stock = current_user.stocks.find_by(symbol: ticker)
    PortStock.create(portfolio_id: port_id, stock_id: stock.id, shares: 0)
  end

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


  def create_stock(ticker, error_code)
    stock_info = Api.get_info(ticker)
    if !current_user.stocks.any? {|x| x.symbol == ticker} && !stock_info.empty?
      stock = Stock.create(:symbol => stock_info['Symbol'], :name => stock_info["Name"], :description => stock_info["Description"], :dividend_per_share => stock_info["DividendPerShare"], :dividend_date => stock_info["DividendDate"], :user_id => current_user.id)
      # redirect_to user_stocks_path(current_user)
    else
      # Print Error
      if error_code == 1
        flash[:notice] = "Error: Stock already exists or ticker is invalid"
      else
        flash[:notice] = "Stock either already exists or is either invalid. If ticker was valid, stock was added to the portfolio."
      end
      # redirect_to user_stocks_path(current_user)
    end
  end

  def stock_params
    params.values_at(:ticker, :portfolio_id)
  end
end
