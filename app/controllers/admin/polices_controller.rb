class Admin::PolicesController < ApplicationController
     before_filter :authenticate_admin!

  def index
    @polices = Police.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @polices }
    end
  end

  def show
    @police = Police.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @police }
    end
  end

  def new
    @police = Police.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @police }
    end
  end

  def edit
    @police = Police.find(params[:id])
  end

  def create
    @police = Police.new(params[:police])
    respond_to do |format|
      if @police.save
        format.html { redirect_to([:admin, @police], :notice => 'Police was successfully created.') }
        format.xml  { render :xml => [:admin, @police], :status => :created, :location =>[:admin, @police] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml =>[:admin, @police].errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @police = Police.find(params[:id])

    respond_to do |format|
      if @police.update_attributes(params[:police])
        format.html { redirect_to([:admin, @police], :notice => 'Police was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => [:admin, @police].errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /polices/1
  # DELETE /polices/1.xml
  def destroy
    @police = Police.find(params[:id])
    @police.destroy

    respond_to do |format|
      format.html { redirect_to(admin_polices_url, :notice => 'Successfully Deleted' )}
      format.xml  { head :ok }
    end
  end

  def cheif
    @police = Police.find(params[:id])
    @police.update_attribute :ischeif, true
    flash[:notice] = "Already set him/her as Chief"
    respond_to do |format|
      format.html{redirect_to(admin_polices_url)}
    end
  end

  def uncheif
    @police = Police.find(params[:id])
    @police.update_attribute :ischeif, false
    flash[:notice] = "Already remove him/her as Chief"
    respond_to do |format|
      format.html{redirect_to(admin_polices_url)}
    end
  end
end
