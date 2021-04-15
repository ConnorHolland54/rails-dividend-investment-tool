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

  def destroy
    portfolio = current_user.portfolios.find_by_id(destroy_params.to_i)
    if portfolio.destroy
      redirect_to user_portfolios_path(current_user.id)
    else
      # Flash error
    end

  end

  private
  def new_port_params
    params.values_at(:name, :user_id)
  end
  def destroy_params
    params.fetch(:id)
  end
end
