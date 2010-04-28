class TagsController < ApplicationController
  def index
    @tags = Tag.all
    respond_to do|format|
      format.html #index.html.erb
    end
  end
  
  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag)
    respond_to do |format|
      format.html #show.html.erb 
    end
  end



end
