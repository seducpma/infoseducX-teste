class SituacaoChamadosController < ApplicationController

    layout "application"

  def index
    @situacao_chamados = SituacaoChamado.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @situacao_chamados }
    end
  end

  def show
    @situacao_chamados = SituacaoChamado.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @situacao_chamados }
    end
  end

  def new
    @situacao_chamados = SituacaoChamado.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @situacao_chamados }
    end
  end

  def edit
    @situacao_chamados = SituacaoChamado.find(params[:id])
  end

  def create
    @situacao_chamados = SituacaoChamado.new(params[:situacao_chamado])
    respond_to do |format|
      if @situacao_chamados.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(new_situacao_chamado_path) }
        format.xml  { render :xml => @situacao_chamados, :status => :created, :location => @situacao_chamados }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @situacao_chamados.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @situacao_chamados = SituacaoChamado.find(params[:id])
    respond_to do |format|
      if @situacao_chamados.update_attributes(params[:situacao_chamado])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@situacao_chamados) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @situacao_chamados.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @situacao_chamados = SituacaoChamado.find(params[:id])
    @situacao_chamados.destroy
    respond_to do |format|
      format.html { redirect_to(new_situacao_chamado_path) }
      format.xml  { head :ok }
    end
  end

  def lista
    @situacao_chamados = SituacaoChamado.find(:all)
    render :partial => 'lista_tipo'
  end
end
