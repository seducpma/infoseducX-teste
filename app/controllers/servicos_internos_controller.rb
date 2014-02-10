class ServicosInternosController < ApplicationController
  # GET /servicos_internos
  # GET /servicos_internos.xml
  def index
    @servicos_internos = ServicosInterno.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servicos_internos }
    end
  end

  # GET /servicos_internos/1
  # GET /servicos_internos/1.xml
  def show
    @servicos_interno = ServicosInterno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @servicos_interno }
    end
  end

  # GET /servicos_internos/new
  # GET /servicos_internos/new.xml
  def new
    @servicos_interno = ServicosInterno.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @servicos_interno }
    end
  end

  # GET /servicos_internos/1/edit
  def edit
    @servicos_interno = ServicosInterno.find(params[:id])
  end

  # POST /servicos_internos
  # POST /servicos_internos.xml
  def create
    @servicos_interno = ServicosInterno.new(params[:servicos_interno])

    respond_to do |format|
      if @servicos_interno.save
        flash[:notice] = 'ServicosInterno was successfully created.'
        format.html { redirect_to(@servicos_interno) }
        format.xml  { render :xml => @servicos_interno, :status => :created, :location => @servicos_interno }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @servicos_interno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /servicos_internos/1
  # PUT /servicos_internos/1.xml
  def update
    @servicos_interno = ServicosInterno.find(params[:id])

    respond_to do |format|
      if @servicos_interno.update_attributes(params[:servicos_interno])
        flash[:notice] = 'ServicosInterno was successfully updated.'
        format.html { redirect_to(@servicos_interno) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @servicos_interno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /servicos_internos/1
  # DELETE /servicos_internos/1.xml
  def destroy
    @servicos_interno = ServicosInterno.find(params[:id])
    @servicos_interno.destroy

    respond_to do |format|
      format.html { redirect_to(servicos_internos_url) }
      format.xml  { head :ok }
    end
  end
end
