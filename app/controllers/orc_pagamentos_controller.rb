class OrcPagamentosController < ApplicationController
  # GET /orc_pagamentos
  # GET /orc_pagamentos.xml

   before_filter :load_iniciais

 def load_iniciais
   #     @pedidos_compra = OrcPedidoCompra.all(:conditions =>['empenhado = 0'],:order => 'codigo ASC')
   #     @despesas = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
   #     @fichas = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')
         @empenhos = OrcEmpenho.all(:conditions => ["year(data) = ? and pagamento=0", Time.now.year])
  #      @orcamentarias= OrcUniOrcamentaria.find(:all, :conditions => ["ano = ?", Time.now.year])
  #      @orc_pedido_ano= OrcPedidoCompra.find(:all, :select => 'distinct(ano)')
 end

  def index
    @orc_pagamentos = OrcPagamento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_pagamentos }
    end
  end

  # GET /orc_pagamentos/1
  # GET /orc_pagamentos/1.xml
  def show
    @orc_pagamento = OrcPagamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_pagamento }
    end
  end

  # GET /orc_pagamentos/new
  # GET /orc_pagamentos/new.xml
  def new
    @orc_pagamento = OrcPagamento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_pagamento }
    end
  end

  # GET /orc_pagamentos/1/edit
  def edit
    @orc_pagamento = OrcPagamento.find(params[:id])
  end

  # POST /orc_pagamentos
  # POST /orc_pagamentos.xml
  def create
    @orc_pagamento = OrcPagamento.new(params[:orc_pagamento])

    respond_to do |format|
      if @orc_pagamento.save

            # atualiza saldo na ficha
        @ficha = OrcFicha.find(:all, :conditions => ['id =?', @orc_pagamento.orc_empenho.orc_pedido_compra.orc_ficha.id])
        saldo_atual= @ficha[0].saldo_atual - @orc_pagamento.valor_pg
        saldo= @ficha[0].saldo - @orc_pagamento.valor_pg
        @ficha[0].saldo_atual = saldo_atual
        @ficha[0].saldo = saldo
        @ficha[0].save
            # Atualiza data pg empenho
        @empenho = OrcEmpenho.find(:all, :conditions => ['id =?', @orc_pagamento.orc_empenho_id])
        @empenho[0].pagamento = 1
        @empenho[0].data_pg = @orc_pagamento.data_pg
        @empenho[0].save


        flash[:notice] = 'OrcPagamento was successfully created.'
        format.html { redirect_to(@orc_pagamento) }
        format.xml  { render :xml => @orc_pagamento, :status => :created, :location => @orc_pagamento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_pagamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_pagamentos/1
  # PUT /orc_pagamentos/1.xml
  def update
    @orc_pagamento = OrcPagamento.find(params[:id])

    respond_to do |format|
      if @orc_pagamento.update_attributes(params[:orc_pagamento])
        flash[:notice] = 'OrcPagamento was successfully updated.'
        format.html { redirect_to(@orc_pagamento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_pagamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_pagamentos/1
  # DELETE /orc_pagamentos/1.xml
  def destroy
    @orc_pagamento = OrcPagamento.find(params[:id])
        # atualiza saldo na ficha
        @ficha = OrcFicha.find(:all, :conditions => ['id =?', @orc_pagamento.orc_empenho.orc_pedido_compra.orc_ficha.id])
        saldo_atual= @ficha[0].saldo_atual - @orc_pagamento.valor_pg
        saldo= @ficha[0].saldo - @orc_pagamento.valor_pg
        @ficha[0].saldo_atual = saldo_atual
        @ficha[0].saldo = saldo
        @ficha[0].save




    @orc_pagamento.destroy

    respond_to do |format|
      format.html { redirect_to(orc_pagamentos_url) }
      format.xml  { head :ok }
    end
  end

def dados_empenho
     @empenho = OrcEmpenho.find(:all, :conditions => ["id =?" , params[:orc_pagamento_orc_empenho_id]])
    render :partial => "empenho"

end



def consulta_pagamentos
end

end
