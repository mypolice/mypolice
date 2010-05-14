class Admin::CommentsController < ApplicationController
   before_filter :authenticate_admin!

  def index
    @comments = Comment.paginate :page=>params[:page], :per_page=>'10', :order=>'created_at DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
      format.json { render :json => @comments}
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end


  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to([:admin, @comment], :notice => 'Comment was successfully updated.') }
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
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(admin_comments_url, :notice =>'Successfully deleted ') }
      format.xml  { head :ok }
    end
  end
 
    def approve
    @comment = Comment.find(params[:id])
    @comment.update_attribute :approved, true
    flash[:notice] = "approved"
    respond_to do |format|
      format.html {redirect_to(admin_comments_url)}
    end
  end

   def unapprove
    @comment = Comment.find(params[:id])
    @comment.update_attribute :approved, false
    flash[:notice] = "unapproved"
    respond_to do |format|
      format.html {redirect_to(admin_comments_url)}
    end
  end

   def approved
    #@posts = Comment.where(:approved => true)
      @comments = Comment.approved.paginate :page=>params[:page], :per_page=>'10', :order=>'created_at DESC'

     render :action=>"index"
   end

   def unapproved
      #@comments = Comment.where(:approved => false)
      @comments = Comment.unapproved.paginate :page=>params[:page], :per_page=>'10', :order=>'created_at DESC'
      render :action=>"index"
  end

end
