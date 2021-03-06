class Admin::ResponsesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @responses = Response.paginate :page=>params[:page], :per_page=>'10', :order=>'created_at DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @responses }
      format.json { render :json => @responses}
    end
  end

  def show
    @response = Response.find(params[:id])
    @post = Post.find(@response.post_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response }
    end
  end


  def edit
    @response = Response.find(params[:id])
  end

  def update
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to([:admin, @response], :notice =>'Response was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to(admin_responses_url, :notice => 'successfully deleted') }
      format.xml  { head :ok }
    end
  end
 
end
