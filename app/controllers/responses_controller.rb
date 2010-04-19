class ResponsesController < ApplicationController
  before_filter :authenticate_police!, :only => [:create]
 
  def create
    @post = Post.find(params[:post_id])
    @response = @post.responses.new(params[:response])
    @response.police = current_police
    @response.save!
    respond_to do |format|
        format.html{ redirect_to @post}
        format.js
    end
  end

end
