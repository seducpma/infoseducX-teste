class SituacaoManutencaosController < ApplicationController
  # GET /situacao_manutencaos
  # GET /situacao_manutencaos.xml

      layout "application"


  def index
    @situacao_manutencaos = SituacaoManutencao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @situacao_manutencaos }
    end
  end

  # GET /situacao_manutencaos/1
  # GET /situacao_manutencaos/1.xml
  def show
    @situacao_manutencao = SituacaoManutencao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @situacao_manutencao }
    end
  end

  # GET /situacao_manutencaos/new
  # GET /situacao_manutencaos/new.xml
  def new
    @situacao_manutencao = SituacaoManutencao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @situacao_manutencao }
    end
  end

  # GET /situacao_manutencaos/1/edit
  def edit
    @situacao_manutencao = SituacaoManutencao.find(params[:id])
  end

  # POST /situacao_manutencaos
  # POST /situacao_manutencaos.xml
  def create
    @situacao_manutencao = SituacaoManutencao.new(params[:situacao_manutencao])

    respond_to do |format|
      if @situacao_manutencao.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@situacao_manutencao) }
        format.xml  { render :xml => @situacao_manutencao, :status => :created, :location => @situacao_manutencao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @situacao_manutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /situacao_manutencaos/1
  # PUT /situacao_manutencaos/1.xml
  def update
    @situacao_manutencao = SituacaoManutencao.find(params[:id])

    respond_to do |format|
      if @situacao_manutencao.update_attributes(params[:situacao_manutencao])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@situacao_manutencao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @situacao_manutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /situacao_manutencaos/1
  # DELETE /situacao_manutencaos/1.xml
  def destroy
    @situacao_manutencao = SituacaoManutencao.find(params[:id])
    @situacao_manutencao.destroy

    respond_to do |format|
      format.html { redirect_to(situacao_manutencaos_url) }
      format.xml  { head :ok }
    end
  end

 def lista
    @situacao_manutencaos = SituacaoManutencao.find(:all)
    render :partial => 'lista_tipo'

  end
end
