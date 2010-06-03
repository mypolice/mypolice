class HomeController < ApplicationController
  def index
    @posts = Post.approved.search(params[:search], 1)
    @users = User.paginate :page=>1, :per_page=>'10', :order=>'created_at DESC'
    @responses = Response.paginate :page=>1, :per_page=>'10', :order=>'created_at DESC'
  end

end
