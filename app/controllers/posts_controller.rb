class PostsController < ApplicationController
  before_filter :clear_step_errors
  #before_filter :get_partial_post_from_session,:only=>[:new, :create]
  #after_filter :save_partial_post_in_session,:only=>[:new,:create]
  
  def index
    if params[:search]
    @posts = Post.approved.paginate(:all, :conditions=>['name LIKE ?',"%#{params[:search]}%"])
    else
    @posts = Post.approved.paginate :page =>params[:page],:per_page=>"10", :order =>'created_at DESC'
    end
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
    if params[:current_step].nil?
      @post = Post.new
      @current_step ='step1' 
    else
      @current_step = params[:current_step]
    end
    respond_to do |format|      
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end


  def create
    @post = Post.new(params[:post])
    @current_step = params[:current_step]
        if @current_step == "step1"
          @current_step = "step2" if valid_for_attributes(@post,[:title])
          respond_to do |format|
            format.html{render :action=> "new",:params => { :current_step => @current_step }}
          end
        elsif @current_step=="step2"
            @current_step = "step3" if valid_for_attributes(@post,[:body])
            respond_to do |format|
              format.html{render :action=> "new",:params => { :current_step => @current_step }}
            end
        elsif @current_step =="step3"
          @post.user = current_user unless current_user.nil? 
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


     def valid_for_attributes(model, attributes)
       debugger 
       unless model.valid?
         errors = model.errors
        # our_errors = Array.new
         errors.each {|attr,error|
          unless attributes.include?(attr)
           errors.delete(attr)
          end
         }
         #errors.clear
         #our_errors.each {|attr,error| errors.add(attr,error)}
         return false unless errors.empty?
        end
          return true
       end

  def clear_step_errors
    unless session['partial_post'].nil?
      session['partial_post'].errors.clear
    end
  end
end




