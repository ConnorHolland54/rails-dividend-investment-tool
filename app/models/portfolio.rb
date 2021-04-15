class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :port_stocks, dependent: :destroy
  has_many :stocks, through: :port_stocks

  def self.dividend_amount(stocks)
    amount = 0
    stocks.each do |s|
      stock = Stock.find(s.stock_id)
      binding.pry
      amount += stock.dividend_per_share.to_i * s.shares
    end
    return amount
  end

end
