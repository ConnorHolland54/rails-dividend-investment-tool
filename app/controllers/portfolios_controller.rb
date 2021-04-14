class PortfoliosController < ApplicationController
  include UsersHelper
  before_action :require_logged_in

  def index
    @user = current_user
    @portfolios = current_user.portfolios
  end

  def create
    user_id = new_port_params[1].to_i
    portfolio = Portfolio.new(name: new_port_params[0], user_id: user_id)
    if portfolio.save
      redirect_to user_portfolios_path(user_id)
    else

    end
  end

  private
  def new_port_params
    params.values_at(:name, :user_id)
  end
end
