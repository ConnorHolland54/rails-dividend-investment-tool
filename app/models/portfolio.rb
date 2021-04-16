class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :port_stocks, dependent: :destroy
  has_many :stocks, through: :port_stocks
  validates :name, presence: true

end
