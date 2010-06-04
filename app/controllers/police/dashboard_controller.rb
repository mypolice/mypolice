class Police::DashboardController < ApplicationController
    layout "police"
    before_filter :authenticate_police!
 
  def index
    @tags = Post.tag_counts
    @posts = Post.approved.paginate :page=>1, :per_page=>'3', :order=>'created_at DESC'  
    @responses = Response.paginate :page=>1, :per_page=>'3', :order=>'created_at DESC'    
  end
end
