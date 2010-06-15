class TagsController < ApplicationController
  layout "twocols"
  navigation :post
  
  def index
    @tags = Tag.paginate :page=>params[:page], :per_page=>'10'
    respond_to do|format|
      format.html #index.html.erb
    end
  end
  
  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag).search(params[:search], params[:page])
    @tags = Post.tag_counts
    @responses = Response.paginate :page=>1, :per_page=>'3', :order=>'created_at DESC' 
    respond_to do |format|
      format.html {render 'posts/index'}
    end
  end



end
