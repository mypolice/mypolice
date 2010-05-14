class Admin::TagsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @tags = Tag.paginate :page=>params[:page], :per_page=>'10'
    respond_to do|format|
      format.html #index.html.erb
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = Post.tagged_with(@tag)
    respond_to do |format|
      format.html #show.html.erb 
    end
  end

  def new
    @tag = Tag.new
    respond_to do |format|
      formt.html #new.html.erb
    end
  end

  def create
    @tag = Tag.new(params[:tag])
    respond_to do |format|
      if @tag.save
        format.html {redirect_to(admin_tags_path, :notice=>'New tag was successfully added')}
      else
        format.html {redirect_to(admin_tags_path, :notice=>'failed to add new tag')}
      end
    end
  end


  def destroy 
    @tag = Tag.find(params[:id])
    @tag.destroy
    respond_to do |format|
      format.html {redirect_to(admin_tags_url, :notice =>'Successfully deleted')}
    end
  end

end
