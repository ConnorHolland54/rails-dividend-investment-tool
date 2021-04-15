class PortStocksController < ApplicationController
  include UsersHelper

  def create
    create_port_stocks
  end
  def remove
    remove_port_stocks
  end

  private

  def port_stock_params
    params.values_at(:port_id, :stock_ids)
  end

  def create_port_stocks
    if port_stock_params[0] != nil
      port_stock_params[1].each do |id|
        if !current_user.portfolios.find_by_id(port_stock_params[0].to_i).stocks.include?(Stock.find(id.to_i))
          port_stock = PortStock.create(portfolio_id: port_stock_params[0].to_i, stock_id: id.to_i, shares: 0)
        end
      end
    else
      # error
    end
    redirect_to "/portfolios/#{port_stock_params[0].to_i}/stocks"
  end

  def remove_port_stocks
    portfolio = current_user.portfolios.find(port_stock_params[0].to_i)
    port_stock_params[1].each do |id|
      port_stock = portfolio.port_stocks.find_by(stock_id: id.to_i)
      port_stock.destroy
    end
    redirect_to "/portfolios/#{port_stock_params[0].to_i}/stocks"
  end
end
