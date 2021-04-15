class StocksController < ApplicationController
  def index
    @user = user?
    if @user
      @user = params[:user_id]
    else
      @user = nil
    end
  end

  private
  def user?
    if params[:user_id]
      return true
    end
    return false
  end
end
