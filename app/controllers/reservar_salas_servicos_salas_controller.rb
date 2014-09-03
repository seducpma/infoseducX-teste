class ReservarSalasServicosSalasController < ApplicationController
  # GET /reservar_salas_servicos_salas
  # GET /reservar_salas_servicos_salas.xml
  def index
    @reservar_salas_servicos_salas = ReservarSalasServicosSala.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reservar_salas_servicos_salas }
    end
  end

  # GET /reservar_salas_servicos_salas/1
  # GET /reservar_salas_servicos_salas/1.xml
  def show
    @reservar_salas_servicos_sala = ReservarSalasServicosSala.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reservar_salas_servicos_sala }
    end
  end

  # GET /reservar_salas_servicos_salas/new
  # GET /reservar_salas_servicos_salas/new.xml
  def new
    @reservar_salas_servicos_sala = ReservarSalasServicosSala.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reservar_salas_servicos_sala }
    end
  end

  # GET /reservar_salas_servicos_salas/1/edit
  def edit
    @reservar_salas_servicos_sala = ReservarSalasServicosSala.find(params[:id])
  end

  # POST /reservar_salas_servicos_salas
  # POST /reservar_salas_servicos_salas.xml
  def create
    @reservar_salas_servicos_sala = ReservarSalasServicosSala.new(params[:reservar_salas_servicos_sala])

    respond_to do |format|
      if @reservar_salas_servicos_sala.save
        flash[:notice] = 'ReservarSalasServicosSala was successfully created.'
        format.html { redirect_to(@reservar_salas_servicos_sala) }
        format.xml  { render :xml => @reservar_salas_servicos_sala, :status => :created, :location => @reservar_salas_servicos_sala }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reservar_salas_servicos_sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reservar_salas_servicos_salas/1
  # PUT /reservar_salas_servicos_salas/1.xml
  def update
    @reservar_salas_servicos_sala = ReservarSalasServicosSala.find(params[:id])

    respond_to do |format|
      if @reservar_salas_servicos_sala.update_attributes(params[:reservar_salas_servicos_sala])
        flash[:notice] = 'ReservarSalasServicosSala was successfully updated.'
        format.html { redirect_to(@reservar_salas_servicos_sala) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reservar_salas_servicos_sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reservar_salas_servicos_salas/1
  # DELETE /reservar_salas_servicos_salas/1.xml
  def destroy
    @reservar_salas_servicos_sala = ReservarSalasServicosSala.find(params[:id])
    @reservar_salas_servicos_sala.destroy

    respond_to do |format|
      format.html { redirect_to(reservar_salas_servicos_salas_url) }
      format.xml  { head :ok }
    end
  end
end
