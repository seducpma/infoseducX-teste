class MmanutencaosTiposManutencaosController < ApplicationController
  # GET /mmanutencaos_tipos_manutencaos
  # GET /mmanutencaos_tipos_manutencaos.xml
  def index
    @mmanutencaos_tipos_manutencaos = MmanutencaosTiposManutencao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mmanutencaos_tipos_manutencaos }
    end
  end

  # GET /mmanutencaos_tipos_manutencaos/1
  # GET /mmanutencaos_tipos_manutencaos/1.xml
  def show
    @mmanutencaos_tipos_manutencao = MmanutencaosTiposManutencao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mmanutencaos_tipos_manutencao }
    end
  end

  # GET /mmanutencaos_tipos_manutencaos/new
  # GET /mmanutencaos_tipos_manutencaos/new.xml
  def new
    @mmanutencaos_tipos_manutencao = MmanutencaosTiposManutencao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mmanutencaos_tipos_manutencao }
    end
  end

  # GET /mmanutencaos_tipos_manutencaos/1/edit
  def edit
    @mmanutencaos_tipos_manutencao = MmanutencaosTiposManutencao.find(params[:id])
  end

  # POST /mmanutencaos_tipos_manutencaos
  # POST /mmanutencaos_tipos_manutencaos.xml
  def create
    @mmanutencaos_tipos_manutencao = MmanutencaosTiposManutencao.new(params[:mmanutencaos_tipos_manutencao])

    respond_to do |format|
      if @mmanutencaos_tipos_manutencao.save
        flash[:notice] = 'Cadastrado com sucesso.'
        format.html { redirect_to(@mmanutencaos_tipos_manutencao) }
        format.xml  { render :xml => @mmanutencaos_tipos_manutencao, :status => :created, :location => @mmanutencaos_tipos_manutencao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mmanutencaos_tipos_manutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mmanutencaos_tipos_manutencaos/1
  # PUT /mmanutencaos_tipos_manutencaos/1.xml
  def update
    @mmanutencaos_tipos_manutencao = MmanutencaosTiposManutencao.find(params[:id])

    respond_to do |format|
      if @mmanutencaos_tipos_manutencao.update_attributes(params[:mmanutencaos_tipos_manutencao])
        flash[:notice] = 'Cadastrado com sucesso.'
        format.html { redirect_to(@mmanutencaos_tipos_manutencao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mmanutencaos_tipos_manutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mmanutencaos_tipos_manutencaos/1
  # DELETE /mmanutencaos_tipos_manutencaos/1.xml
  def destroy
    @mmanutencaos_tipos_manutencao = MmanutencaosTiposManutencao.find(params[:id])
    @mmanutencaos_tipos_manutencao.destroy

    respond_to do |format|
      format.html { redirect_to(mmanutencaos_tipos_manutencaos_url) }
      format.xml  { head :ok }
    end
  end
end
