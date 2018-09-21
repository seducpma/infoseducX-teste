class OrcPedidoDescricaosController < ApplicationController
  # GET /orc_pedido_descricaos
  # GET /orc_pedido_descricaos.xml
  def index
    @orc_pedido_descricaos = OrcPedidoDescricao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_pedido_descricaos }
    end
  end

  # GET /orc_pedido_descricaos/1
  # GET /orc_pedido_descricaos/1.xml
  def show
    @orc_pedido_descricao = OrcPedidoDescricao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_pedido_descricao }
    end
  end

  # GET /orc_pedido_descricaos/new
  # GET /orc_pedido_descricaos/new.xml
  def new
    @orc_pedido_descricao = OrcPedidoDescricao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_pedido_descricao }
    end
  end

  # GET /orc_pedido_descricaos/1/edit
  def edit
    @orc_pedido_descricao = OrcPedidoDescricao.find(params[:id])
  end

  # POST /orc_pedido_descricaos
  # POST /orc_pedido_descricaos.xml
  def create
    @orc_pedido_descricao = OrcPedidoDescricao.new(params[:orc_pedido_descricao])

    respond_to do |format|
      if @orc_pedido_descricao.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@orc_pedido_descricao) }
        format.xml  { render :xml => @orc_pedido_descricao, :status => :created, :location => @orc_pedido_descricao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_pedido_descricao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_pedido_descricaos/1
  # PUT /orc_pedido_descricaos/1.xml
  def update
    @orc_pedido_descricao = OrcPedidoDescricao.find(params[:id])

    respond_to do |format|
      if @orc_pedido_descricao.update_attributes(params[:orc_pedido_descricao])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@orc_pedido_descricao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_pedido_descricao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_pedido_descricaos/1
  # DELETE /orc_pedido_descricaos/1.xml
  def destroy
    @orc_pedido_descricao = OrcPedidoDescricao.find(params[:id])
    @orc_pedido_descricao.destroy

    respond_to do |format|
      format.html { redirect_to(orc_pedido_descricaos_url) }
      format.xml  { head :ok }
    end
  end


end
