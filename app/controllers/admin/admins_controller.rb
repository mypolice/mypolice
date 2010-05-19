class Admin::PolicesController < ApplicationController
     before_filter :authenticate_admin!

  def index
   # @polices = Admin.all
    @polices = Admin.paginate :page=>params[:page], :per_page=>'10', :order=>'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @polices }
    end
  end

  def show
    @admin = Admin.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  def new
    @admin = Admin.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(params[:admin])
    respond_to do |format|
      if @admin.save
        format.html { redirect_to([:admin, @admin], :notice => 'Admin was successfully created.') }
        format.xml  { render :xml => [:admin, @admin], :status => :created, :location =>[:admin, @admin] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml =>[:admin, @admin].errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to([:admin, @admin], :notice => 'Admin was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => [:admin, @admin].errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /polices/1
  # DELETE /polices/1.xml
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to(admin_polices_url, :notice => 'Successfully Deleted' )}
      format.xml  { head :ok }
    end
  end

  def cheif
    @admin = Admin.find(params[:id])
    @admin.update_attribute :ischeif, true
    flash[:notice] = "Already set him/her as Chief"
    respond_to do |format|
      format.html{redirect_to(admin_polices_url)}
    end
  end

  def uncheif
    @admin = Admin.find(params[:id])
    @admin.update_attribute :ischeif, false
    flash[:notice] = "Already remove him/her as Chief"
    respond_to do |format|
      format.html{redirect_to(admin_polices_url)}
    end
  end
end
