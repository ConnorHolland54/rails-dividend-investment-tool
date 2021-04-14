class PortfoliosController < ApplicationController
  include UsersHelper
  before_action :require_logged_in
  
  def index
  end
end
