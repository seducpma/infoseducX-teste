class ReservarSalasController < ApplicationController
  # GET /reservar_salas
  # GET /reservar_salas.xml

before_filter :load_salas
before_filter :load_servicos_salas
layout :define_layout
before_filter :login_required, :except => ["index", "show", "create", "new","edit"]

 def load_servicos_salas
  @servicos_salas = ServicosSala.find(:all)
  end

 def load_salas
  @salas = Sala.find(:all, :order => "sala ASC")
  end

  def index
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @reservar_salas = ReservarSala.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reservar_salas }
    end
  end

  # GET /reservar_salas/1
  # GET /reservar_salas/1.xml
  def show
    @reservar_sala = ReservarSala.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reservar_sala }
    end
  end

  # GET /reservar_salas/new
  # GET /reservar_salas/new.xml
  def new
    @reservar_sala = ReservarSala.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reservar_sala }
    end
  end

  # GET /reservar_salas/1/edit
  def edit
    @reservar_sala = ReservarSala.find(params[:id])
  end

  # POST /reservar_salas
  # POST /reservar_salas.xml
  def create
    @reservar_sala = ReservarSala.new(params[:reservar_sala])

    respond_to do |format|
      if @reservar_sala.save
        flash[:notice] = 'Cadastrado com sucesso.'
        format.html { redirect_to(@reservar_sala) }
        format.xml  { render :xml => @reservar_sala, :status => :created, :location => @reservar_sala }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reservar_sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reservar_salas/1
  # PUT /reservar_salas/1.xml
  def update
    @reservar_sala = ReservarSala.find(params[:id])

    respond_to do |format|
      if @reservar_sala.update_attributes(params[:reservar_sala])
        flash[:notice] = 'Cadastrado com sucesso.'
        format.html { redirect_to(@reservar_sala) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reservar_sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reservar_salas/1
  # DELETE /reservar_salas/1.xml
  def destroy
    @reservar_sala = ReservarSala.find(params[:id])
    @reservar_sala.destroy

    respond_to do |format|
      format.html { redirect_to(reservar_salas_url) }
      format.xml  { head :ok }
    end
  end


   def define_layout
    if logged_in?
      'application'
    else
      'login'
    end
  end


def lista
     $sala = params[:reservar_sala_sala_id]
     @reservar_sala = ReservarSala(:all, :conditions => ['sala_id=' + $sala])
    render :partial => 'lista_capacidade'
  end
end
