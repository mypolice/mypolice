class Police::DashboardController < ApplicationController
    before_filter :authenticate_police!
 
  def index
  end
end
