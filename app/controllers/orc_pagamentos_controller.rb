class OrcPagamentosController < ApplicationController
  # GET /orc_pagamentos
  # GET /orc_pagamentos.xml

   before_filter :load_iniciais

 def load_iniciais
   #     @pedidos_compra = OrcPedidoCompra.all(:conditions =>['empenhado = 0'],:order => 'codigo ASC')
   #     @despesas = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
         @fichas = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')
         #@fichas = OrcFicha.find_by_sql("SELECT id, ficha FROM orc_pagamentos WHERE id NOT IN (SELECT orc_ficha_id FROM orc_pagamentos) ORDER BY codigo ASC")
         @orc_pagamento_op= OrcPagamento.find(:all, :conditions => ["year(data_pg) = ? and codigo is not null AND  orc_empenho_id is not null"  , Time.now.year], :order => 'data_pg ASC' )
         @empenhos = OrcEmpenho.all(:conditions => ["year(data_chegou) = ? and pagamento=0", Time.now.year], :order => 'data_chegou ASC' )
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

    @ficha = OrcFicha.find(:all, :conditions => ['id =?', @orc_pagamento.orc_ficha_id])

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
        @orc_pagamento.pago = 1
      if @orc_pagamento.save
       op_id=@orc_pagamento.id
       @empenho = OrcEmpenho.find(:all, :conditions => ['id=?', @orc_pagamento.orc_empenho_id])
            # atualiza saldo na ficha
       if @orc_pagamento.orc_empenho_id.nil?
           @ficha = OrcFicha.find(:all, :conditions => ['id =?', @orc_pagamento.orc_ficha_id])
           @empenho[0].pago=1
           @empenho[0].save
       else
           @ficha = OrcFicha.find(:all, :conditions => ['id =?',session[:ficha_id]])
           
           @orc_pagamento.interessado=@empenho[0].interessado
           @empenho[0].pago=1
           @orc_pagamento.save
           @empenho[0].save
       end

        @orc_pagamento.ficha = @ficha[0].ficha
        saldo_atual= @ficha[0].saldo_atual - @orc_pagamento.valor_pg
        saldo= @ficha[0].saldo - @orc_pagamento.valor_pg
        if !@orc_pagamento.orc_empenho_id.nil?
           empenho= @ficha[0].saldo_empenhado - @orc_pagamento.valor_pg
           @ficha[0].saldo_empenhado = empenho
        end
        @ficha[0].saldo_atual = saldo_atual
        @ficha[0].saldo = saldo
        @ficha[0].save
        @orc_pagamento.save
            # Atualiza data pg empenho
        if !@orc_pagamento.orc_empenho_id.nil?
            @op =OrcPagamento.find(op_id)
            @empenho = OrcEmpenho.find(:all, :conditions => ['id =?', @orc_pagamento.orc_empenho_id])
            empenho_id=@empenho[0].orc_pedido_compra_id
            @pedido_compra = OrcPedidoCompra.find(:all , :conditions=> ['id= ?', empenho_id])
            @empenho[0].pagamento = 1
            @empenho[0].data_pg = @orc_pagamento.data_pg
            @op.codigo= @empenho[0].codigo
            @ficha= OrcFicha.find(:all, :conditions => ['ficha =?',@empenho[0].ficha])

            @op.orc_ficha_id = @ficha[0].id
            @op.interessado = @empenho[0].interessado
            @op.codigo = @empenho[0].codigo
            @op.ficha = @empenho[0].ficha
            if !@empenho[0].orc_pedido_compra_id.nil?
               @pedido_compra[0].empenhado =1
               @pedido_compra[0].save
               @empenho[0].save
            end
            @op.save
        end

        flash[:notice] = 'SALVO COM SUCESSO.'
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
        flash[:notice] = 'SALVO COM SUCESSO.'
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
    @ficha = OrcFicha.find(:all, :conditions => ['ficha =?',@empenho[0].ficha])
    session[:ficha]= @empenho[0].ficha
    session[:ficha_id]=@ficha[0].id

      @ficha = OrcFicha.find(:all, :conditions => ['ficha =?', session[:ficha]])
   
    render :partial => "empenho"

end



def consulta_pagamentos
end


 def consulta_pagamento
    if params[:type_of].to_i == 1   #fornecedor
         @pagamentos = OrcPagamento.find(:all,   :conditions => ['interessado like ?', "%" + params[:search_fornecedor1].to_s + "%"], :order => 'id DESC')
          render :update do |page|
                page.replace_html 'consultapagamento', :partial => "pagamentos"
          end
    else if params[:type_of].to_i == 3   #prpduto
        #          @pedidos_compra = OrcPedidoCompra.find(:all,:conditions => ['id != 1 and objetivo like ?', "%" + params[:search_produto].to_s + "%"], :order => 'id DESC')
               render :update do |page|
                  page.replace_html 'consultapedido', :partial => "pedidos"
               end
         else if params[:type_of].to_i == 4   #todas
                      @pagamentos= OrcPagamento.find(:all, :order => 'data_pg DESC')
                   render :update do |page|
                      page.replace_html 'consultapagamento', :partial => "pagamentos"
                   end
              end
       end
     end
end

def pagamento_op
  @pagamentos = OrcPagamento.find(:all, :conditions => ['orc_empenho_id = ?', params[:orc_pagamento_orc_empenho_id]], :order => 'data_pg DESC')
  
    render :partial => "pagamentos"

end

def ficha_pagamento
     session[:ficha]= 1
  @pagamentos = OrcPagamento.find(:all, :conditions => ['orc_ficha_id = ?', params[:orc_pagamento_orc_ficha_id]], :order => 'data_pg DESC')
  render :partial => "pagamentos"

end

 def dados_ficha
    @dados_ficha=  OrcFicha.find(:all, :conditions => ['id = ?',params[:orc_pagamento_orc_ficha_id]])

     render :partial => "dados_fichas"
end

end
