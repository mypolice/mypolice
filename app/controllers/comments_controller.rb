class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    @comment.user = current_user
    flash[:notice] = "Thanks for your comment! It will be appproved soon"  
    respond_to do |format|
      if @comment.save
        format.html{ redirect_to @post, :notice =>"comment was created, but need to be approved"}
        format.js
      else 
        format.html {redirect_to @post, :notice => "failed"}
      end
    end
  end
end

