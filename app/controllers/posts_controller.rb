class PostsController < ApplicationController
  before_filter :clear_step_errors
  respond_to :html, :xml, :json ,:except=>:index
  respond_to :atom, :only=>:index
  layout "twocols", :except=>[:new]
  navigation :post
  
  def index
    @posts = Post.approved.search(params[:search], params[:page])
    @responses = Response.paginate :page=>1, :per_page=>'3', :order=>'created_at DESC'    
    @tags = Post.tag_counts
    respond_to do |format|
      format.html
      format.xml{render :xml=>@posts}
      format.atom
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.approved.find(params[:id])
    respond_with(@post)
  end

  # GET /posts/new
  # GET /posts/new.xml
=begin
  def new
    if params[:current_step].nil?
      @post = Post.new(params[:post])
      @address = Address.new(params[:address])
      @current_step ='step1'
    else
      @current_step = params[:current_step]
      @post = Post.new(params[:post])
    end
    respond_with(@post) do |format|
      format.html{render :action=>:new, :layout=>"application"}
    end
  end

  def create
    @address = Address.new(params[:address])
    @post = Post.new(params[:post])
    @current_step = params[:current_step]
    case @current_step
       when "step1" then
        @current_step = 'step2' if valid_for_attributes(@post,[:title]) and @address.valid?
        respond_with(@post) do |format|
         format.html{render :action=> "new",:layout=>"application", :params => { :current_step => @current_step }}
        end
      when "step2" then
        @current_step = 'step3' if valid_for_attributes(@post,[:body])
         respond_with(@post) do |format|
         format.html{render :action=> "new", :layout=>"application",:params => { :current_step => @current_step }}
        end
       when "step3" then
          @post.user = current_user unless current_user.nil? 
          if @post.save and @address.save
            @post.address_id = @address.id
            @post.save
            flash[:notice] = "Thanks for your sharing, Please wait for approval"
          end
          respond_with(@post) do |format|
              format.html { redirect_to posts_path}
          end
        end
  end
=end

  def new
    @post = Post.new
    @address = Address.new
    respond_with(@post) do |format|
      format.html{render :action=>:new, :layout=>"application"}
    end      
  end

  def create
    @post = Post.new(params[:post]) 
    @post.happened_on_year = params[:date]['happened_on_year'].to_i;
    @post.happened_on_month = params[:date]['happened_on_month'].to_i;
    @post.happened_on_day = params[:date]['happened_on_day'].to_i;
    @address = Address.new(params[:address])
    if @post.save and @address.save
      @post.address_id = @address.id
      @post.save
      #flash[:notice] = "successfully created Story"
      params[:post]=params[:address]=nil
      render "thankyou", :layout=>"application"
    else
      flash[:notice] = "failed"
      render :action=>"new", :layout=>"application"
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




