class Police::PolicesController < ApplicationController
  before_filter :authenticate_police!
  def show
    @police = Police.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @police }
    end
  end
  
  def edit
    @police = Police.find(current_police)
  end

  def update
    @police = Police.find(current_police)
    respond_to do |format|
      if @police.update_attributes(params[:police])
        format.html { redirect_to([:police, @police], :notice => 'Police profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @police.errors, :status => :unprocessable_entity }
      end
    end
  end


end
