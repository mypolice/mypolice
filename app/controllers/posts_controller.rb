class PostsController < ApplicationController
#before_filter :clear_step_errors
  before_filter :get_partial_post_from_session,:only=>[:new, :create]
  after_filter :save_partial_post_in_session,:only=>[:new,:create]
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
    if params['current_step'].nil?
      session['partial_post']=nil
      @post = Post.new
      @current_step ='step1' 
    else
      @current_step = params['current_step']
    end
    respond_to do |format|      
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def create
     @current_step = params['current_step']
        if @current_step == "step1"
          @post.attributes = params['post']
          @post.user = current_user
          @current_step = "step2"           
          respond_to do |format|
            @post.valid?
            if @post.errors.empty? || @post.errors.invalid?(:title)
            format.html{render :action=> "new",:params => { :current_step => @current_step }}
            else
            format.html{render :action=> "new",:params => { :current_step => "step1" }}
            end
          end
        elsif @current_step=="step2"
            @post.attributes = params['post']
            @current_step = "step3"
            respond_to do |format|
              format.html{render :action=> "new",:params => { :current_step => @current_step }}
            end
        elsif @current_step =="step3"
          @post.attributes = params['post']
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

private
    def get_partial_post_from_session
      unless session['partial_post'].nil?
        @post = session['partial_post']
      else
        @post = Post.new
      end
    end

     def save_partial_post_in_session
       unless @post.nil?
         session['partial_post']=@post
       end
     end

     def valid_for_attributes(model, attributes)
       unless model.valid?
         errors = model.errors
         our_errors = Array.new
         errors.each{|attr,error|
          if attributes.include? attr
            our_errors<<[attr,error]
          end
         }
         errors.clear
         our_errors.each{|attr,error| error.add(attr,error)}
         return false 
          unless errors.empty?
          end
          return true
       end
  end
  def clear_step_errors
    unless @session['partial_post'].nil?
      @session['partial_post'].errors.clear
    end
  end
end
