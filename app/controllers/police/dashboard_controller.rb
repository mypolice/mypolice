class Police::DashboardController < ApplicationController
    before_filter :authenticate_police!
 
  def index
    @posts = Post.approved.search(params[:search],params[:page]) 
  end
end
