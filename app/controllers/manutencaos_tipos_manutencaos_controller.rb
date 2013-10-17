class ManutencaosTiposManutencaosController < ApplicationController
  # GET /manutencaos_tipos_manutencaos
  # GET /manutencaos_tipos_manutencaos.xml
  def index
    @manutencaos_tipos_manutencaos = ManutencaosTiposManutencao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @manutencaos_tipos_manutencaos }
    end
  end

  # GET /manutencaos_tipos_manutencaos/1
  # GET /manutencaos_tipos_manutencaos/1.xml
  def show
    @manutencaos_tipos_manutencao = ManutencaosTiposManutencao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @manutencaos_tipos_manutencao }
    end
  end

  # GET /manutencaos_tipos_manutencaos/new
  # GET /manutencaos_tipos_manutencaos/new.xml
  def new
    @manutencaos_tipos_manutencao = ManutencaosTiposManutencao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @manutencaos_tipos_manutencao }
    end
  end

  # GET /manutencaos_tipos_manutencaos/1/edit
  def edit
    @manutencaos_tipos_manutencao = ManutencaosTiposManutencao.find(params[:id])
  end

  # POST /manutencaos_tipos_manutencaos
  # POST /manutencaos_tipos_manutencaos.xml
  def create
    @manutencaos_tipos_manutencao = ManutencaosTiposManutencao.new(params[:manutencaos_tipos_manutencao])

    respond_to do |format|
      if @manutencaos_tipos_manutencao.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@manutencaos_tipos_manutencao) }
        format.xml  { render :xml => @manutencaos_tipos_manutencao, :status => :created, :location => @manutencaos_tipos_manutencao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @manutencaos_tipos_manutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manutencaos_tipos_manutencaos/1
  # PUT /manutencaos_tipos_manutencaos/1.xml
  def update
    @manutencaos_tipos_manutencao = ManutencaosTiposManutencao.find(params[:id])

    respond_to do |format|
      if @manutencaos_tipos_manutencao.update_attributes(params[:manutencaos_tipos_manutencao])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@manutencaos_tipos_manutencao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @manutencaos_tipos_manutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manutencaos_tipos_manutencaos/1
  # DELETE /manutencaos_tipos_manutencaos/1.xml
  def destroy
    @manutencaos_tipos_manutencao = ManutencaosTiposManutencao.find(params[:id])
    @manutencaos_tipos_manutencao.destroy

    respond_to do |format|
      format.html { redirect_to(manutencaos_tipos_manutencaos_url) }
      format.xml  { head :ok }
    end
  end
end
