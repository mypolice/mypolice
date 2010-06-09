class Admin::PostsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @posts = Post.paginate :all, :page=>params[:page], :per_page=>'2', :order =>'created_at DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.json { render :json => @posts}
      format.atom
    end
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to([:admin, @post], :notice => 'Post was successfully updated.') }
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
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to(admin_posts_url, :notice => 'Successfully deleted') }
      format.xml  { head :ok }
    end
  end
 
  def approve
    @post = Post.find(params[:id])
    @post.update_attribute :approved, true
    flash[:notice] = @post.title << " has been approved"
    respond_to do |format|
      format.html {redirect_to(admin_posts_url)}
    end
  end

   def unapprove
    @post = Post.find(params[:id])
    @post.update_attribute :approved, false
    flash[:notice] = "unapproved"
    respond_to do |format|
      format.html {redirect_to(admin_posts_url)}
    end
  end

   def approved
    #@posts = Post.where(:approved => true)
    @posts = Post.approved.paginate :all, :page=>params[:page], :per_page=>'10', :order =>'created_at DESC'
     render :action=>"index"
   end

   def unapproved
      #@posts = Post.where(:approved => false)
     @posts = Post.unapproved.paginate :all, :page=>params[:page], :per_page=>'10', :order =>'created_at DESC' 
     render :action=>"index"
  end
end
