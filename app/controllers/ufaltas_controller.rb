class UfaltasController < ApplicationController
  def index
    @ufaltas = Ufalta.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ufaltas }
    end
  end

  def show
    @ufalta = Ufalta.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ufalta }
    end
  end

  def new
    @ufalta = Ufalta.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ufalta }
    end
  end

  def edit
    @ufalta = Ufalta.find(params[:id])
  end

  def create
    @ufalta = Ufalta.new(params[:ufalta])
    respond_to do |format|
      if @ufalta.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@ufalta) }
        format.xml  { render :xml => @ufalta, :status => :created, :location => @ufalta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ufalta.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @ufalta = Ufalta.find(params[:id])
    respond_to do |format|
      if @ufalta.update_attributes(params[:ufalta])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@ufalta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ufalta.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @ufalta = Ufalta.find(params[:id])
    @ufalta.destroy
    respond_to do |format|
      format.html { redirect_to(ufaltas_url) }
      format.xml  { head :ok }
    end
  end
end
