class HomeController < ApplicationController
  def index
    @posts = Post.approved.paginate :page=>1, :per_page=>'3', :order=>'created_at DESC'
    @users = User.paginate :page=>1, :per_page=>'10', :order=>'created_at DESC'
    @responses = Response.paginate :page=>1, :per_page=>'10', :order=>'created_at DESC'
  end

end
