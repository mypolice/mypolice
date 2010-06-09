class ResponsesController < ApplicationController
  before_filter :authenticate_police!, :only => [:create]
  def new
    @reponse = Response.new
  end

  def create
    @post = Post.find(params[:post_id])
    @response = @post.responses.new(params[:response])
    @response.police = current_police
    respond_to do |format|
      if @response.save
        flash[:notice] = "Thanks for your response!"
        format.html{ redirect_to @post}
        format.js
      else
        redirect_to root_path
      end
    end
  end

end
