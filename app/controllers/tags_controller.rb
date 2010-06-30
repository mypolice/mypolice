class TagsController < ApplicationController
  layout "twocols"
  navigation :post
  
  def index
    if params[:term]
      @tags= Tag.all(:conditions=>["name like ?",params[:term]+'%'])
    else
      @tags = Tag.paginate :page=>params[:page], :per_page=>'10'
    end
    respond_to do |format|
      format.html #index.html.erb
      format.json {render:json=>@tags}
    end
  end
  
  def show
    @tag = Tag.find(params[:id])
    @posts = Post.approved.tagged_with(@tag).search(params[:search], params[:page])
    @tags = Post.approved.tag_counts
    @responses = Response.paginate :page=>1, :per_page=>'3', :order=>'created_at DESC' 
    respond_to do |format|
      format.html {render 'posts/index'}
    end
  end



end
