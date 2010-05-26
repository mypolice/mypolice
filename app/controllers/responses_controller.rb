class ResponsesController < ApplicationController
  before_filter :authenticate_police!, :only => [:create]
  

  def create
    @post = Post.find(params[:post_id])
    @response = @post.responses.new(params[:response])
    @response.police = current_police
    respond_to do |format|
      if @response.save
        flash[:notice] = "Thanks for your response!"
        format.html{ redirect_to @post}
        format.js
      end
    end
  end

end
