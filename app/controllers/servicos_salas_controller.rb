class ServicosSalasController < ApplicationController
  def index
    @servicos_salas = ServicosSala.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servicos_salas }
    end
  end

  def show
    @servicos_sala = ServicosSala.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @servicos_sala }
    end
  end

  def new
    @servicos_sala = ServicosSala.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @servicos_sala }
    end
  end

  def edit
    @servicos_sala = ServicosSala.find(params[:id])
  end

  def create
    @servicos_sala = ServicosSala.new(params[:servicos_sala])
    respond_to do |format|
      if @servicos_sala.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@servicos_sala) }
        format.xml  { render :xml => @servicos_sala, :status => :created, :location => @servicos_sala }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @servicos_sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @servicos_sala = ServicosSala.find(params[:id])
    respond_to do |format|
      if @servicos_sala.update_attributes(params[:servicos_sala])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@servicos_sala) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @servicos_sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @servicos_sala = ServicosSala.find(params[:id])
    @servicos_sala.destroy
    respond_to do |format|
      format.html { redirect_to(servicos_salas_url) }
      format.xml  { head :ok }
    end
  end
end
