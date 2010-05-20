class Admin::WhosController < ApplicationController
  before_filter :authenticate_admin!

  def index
   # @who = Who.all
    @whos = Who.paginate :page=>params[:page], :per_page=>'20', :order=>'created_at DESC'

    respond_to do|format|
      format.html
      format.xml { render :xml=>@whos}
    end
  end

  def new
    @who = Who.new
    respond_to do|format|
      format.html
      format.xml {render :xml=>@who}
    end
  end

  def create
    @who = Who.new(params[:who])
    respond_to do|format|
      if @who.save
        format.html{redirect_to([:admin, @who], :notice=>"Who was successfully create")}
        format.xml {render :xml=>@whos}
      else
        format.html {render :action=>"new"}
        format.xml{render :xml=>[:admin, @who].errors, :status => :unprocessable_entity}
      end
    end
  end

  def show
    @who = Who.find(params[:id])
    respond_to do |format|
      format.html
      format.xml{render :xml => @who}
    end
  end
  def edit
    @who = Who.find(params[:id])
  end

  def update
    @who = Who.find(params[:id])

    respond_to do |format|
      if @who.update_attributes(params[:user])
        format.html { redirect_to([:admin, @who], :notice => 'Who was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => [:admin, @who.errors], :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @who = Who.find(params[:id])
    @who.destroy

    respond_to do |format|
      format.html { redirect_to(admin_whos_url, :notice => 'Successfully deleted') }
      format.xml  { head :ok }
    end
  end  

end
