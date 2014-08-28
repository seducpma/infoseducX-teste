class SalasController < ApplicationController
  # GET /salas
  # GET /salas.xml
  def index
    @salas = Sala.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @salas }
    end
  end

  # GET /salas/1
  # GET /salas/1.xml
  def show
    @sala = Sala.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sala }
    end
  end

  # GET /salas/new
  # GET /salas/new.xml
  def new
    @sala = Sala.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sala }
    end
  end

  # GET /salas/1/edit
  def edit
    @sala = Sala.find(params[:id])
  end

  # POST /salas
  # POST /salas.xml
  def create
    @sala = Sala.new(params[:sala])

    respond_to do |format|
      if @sala.save
        flash[:notice] = 'Sala was successfully created.'
        format.html { redirect_to(@sala) }
        format.xml  { render :xml => @sala, :status => :created, :location => @sala }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /salas/1
  # PUT /salas/1.xml
  def update
    @sala = Sala.find(params[:id])

    respond_to do |format|
      if @sala.update_attributes(params[:sala])
        flash[:notice] = 'Sala was successfully updated.'
        format.html { redirect_to(@sala) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /salas/1
  # DELETE /salas/1.xml
  def destroy
    @sala = Sala.find(params[:id])
    @sala.destroy

    respond_to do |format|
      format.html { redirect_to(salas_url) }
      format.xml  { head :ok }
    end
  end
end
