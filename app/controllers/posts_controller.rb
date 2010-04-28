class PostsController < ApplicationController
  def index
    @posts = Post.approved.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.json { render :json => @posts}
      format.atom
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.approved.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @post.user = current_user
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end


  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to(posts_path, :notice => 'Thanks for your sharing, Please wait for approval') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

 
end
