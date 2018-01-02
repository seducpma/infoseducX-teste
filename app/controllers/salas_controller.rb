class SalasController < ApplicationController
  def index
    @salas = Sala.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @salas }
    end
  end

  def show
    @sala = Sala.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sala }
    end
  end

  def new
    @sala = Sala.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sala }
    end
  end

  def edit
    @sala = Sala.find(params[:id])
  end

  def create
    @sala = Sala.new(params[:sala])
    respond_to do |format|
      if @sala.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@sala) }
        format.xml  { render :xml => @sala, :status => :created, :location => @sala }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @sala = Sala.find(params[:id])
    respond_to do |format|
      if @sala.update_attributes(params[:sala])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@sala) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @sala = Sala.find(params[:id])
    @sala.destroy
    respond_to do |format|
      format.html { redirect_to(salas_url) }
      format.xml  { head :ok }
    end
  end
end
