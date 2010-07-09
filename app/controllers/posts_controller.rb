class PostsController < ApplicationController
  before_filter :clear_step_errors
  respond_to :html, :xml, :json ,:except=>:index
  respond_to :atom, :only=>:index
  layout "twocols", :except=>[:new]
  navigation :post
  
  def index
    @posts = Post.approved.search(params[:search], params[:page])
    @responses = Response.paginate :page=>1, :per_page=>'3', :order=>'created_at DESC'    
    @tags = Post.approved.tag_counts
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

    
  def new
    @post = Post.new
    @address = Address.new
    @storydata=Storydata.new
    @contactways={"By telephone call (not 999)"=>1,"By personal visit to a police station" =>2, "999 call"=>3, "Direct to a police officer"=>4, "The police contacted you"=>5,"other method"=>6}
    @afterreport={"Entirely over the phone"=>1,"By an officer or other member of police staff"=>2,"At the police station"=>3}  
    @howlongarrivetold={"As soon as they could"=>1, "Within 10 minutes"=>2,"Within 1 hour"=>3,"Within 4 hours"=>4,"At an agreed time later the same day"=>5," At an agreed time on another day"=>6,"At an agreed time on another day"=>7}
    @howlongarrive={"Within 10 minutes"=>1, "Within 1 hour"=>2, "Within 4 hours"=>3, "At an agreed time appointment time"=>4, "Later than the agreed appointment time"=>5, "Earlier than the agreed appointment time"=>6,"Never arrived"=>7,"Don't know/can't remember"=>8}

    respond_with(@post) do |format|
      format.html{render :action=>:new, :layout=>"newstory"}
    end      
  end

  def create
    @post = Post.new(params[:post])  
    @address = Address.new(params[:address])
    @storydata=Storydata.new(params[:storydata])
    @storydata.happened_on_year = params[:date]['happened_on_year'].to_i;
    @storydata.happened_on_month = params[:date]['happened_on_month'].to_i;
    @storydata.happened_on_day = params[:date]['happened_on_day'].to_i;
    if @post.save and @address.save
      @storydata.save
      @post.address_id = @address.id
      @post.storydata_id=@storydata.id
      @storydata.post_id=@post.id
      @storydata.save
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




