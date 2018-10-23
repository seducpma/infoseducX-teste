class OrcReservasController < ApplicationController
  # GET /orc_reservas
  # GET /orc_reservas.xml
  def index
    @orc_reservas = OrcReserva.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_reservas }
    end
  end

  # GET /orc_reservas/1
  # GET /orc_reservas/1.xml
  def show
    @orc_reserva = OrcReserva.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_reserva }
    end
  end

  # GET /orc_reservas/new
  # GET /orc_reservas/new.xml
  def new
    @orc_reserva = OrcReserva.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_reserva }
    end
  end

  # GET /orc_reservas/1/edit
  def edit
    @orc_reserva = OrcReserva.find(params[:id])
  end

  # POST /orc_reservas
  # POST /orc_reservas.xml
  def create
    @orc_reserva = OrcReserva.new(params[:orc_reserva])

    respond_to do |format|
      if @orc_reserva.save
        flash[:notice] = 'OrcReserva was successfully created.'
        format.html { redirect_to(@orc_reserva) }
        format.xml  { render :xml => @orc_reserva, :status => :created, :location => @orc_reserva }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_reserva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_reservas/1
  # PUT /orc_reservas/1.xml
  def update
    @orc_reserva = OrcReserva.find(params[:id])

    respond_to do |format|
      if @orc_reserva.update_attributes(params[:orc_reserva])
        flash[:notice] = 'OrcReserva was successfully updated.'
        format.html { redirect_to(@orc_reserva) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_reserva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_reservas/1
  # DELETE /orc_reservas/1.xml
  def destroy
    @orc_reserva = OrcReserva.find(params[:id])
    @orc_reserva.destroy

    respond_to do |format|
      format.html { redirect_to(orc_reservas_url) }
      format.xml  { head :ok }
    end
  end
end
