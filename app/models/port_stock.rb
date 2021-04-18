class PortStock < ApplicationRecord
  belongs_to :portfolio
  belongs_to :stock

  scope :order_by_shares, -> { order(shares: :desc) }

  def symbol
    stock = Stock.find(self.stock_id)
    stock.symbol
  end

  def name
    stock = Stock.find(self.stock_id)
    stock.name
  end
end
