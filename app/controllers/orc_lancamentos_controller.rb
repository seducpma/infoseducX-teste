class OrcLancamentosController < ApplicationController
  # GET /orc_empenhos
  # GET /orc_empenhos.xml

     before_filter :load_iniciais

 def load_iniciais
        @pedidos_compra = OrcPedidoCompra.all(:order => 'codigo ASC')
        @despesas = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
        @fichas_emp = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')
        @fichas = OrcEmpenho.find_by_sql("SELECT DISTINCT (fc.ficha) as ficha, emp.orc_pedido_compra_id, fc.id FROM orc_empenhos emp INNER JOIN orc_pedido_compras pc ON emp.orc_pedido_compra_id = pc.id INNER JOIN orc_fichas fc ON pc.orc_ficha_id = fc.id WHERE (fc.ano = "+(Time.now.year).to_s+" AND emp.id !=1 ) ORDER BY fc.ficha ASC")

        @orcamentarias= OrcUniOrcamentaria.find(:all, :conditions => ["ano = ?", Time.now.year])
          @orc_pedido_ano= OrcPedidoCompra.find(:all, :select => 'distinct(ano)')
 end


  def show
    @orc_empenho = OrcEmpenho.find(params[:id])
    @orc_empenho_itens = OrcEmpenhoIten.find(:all, :conditions => ['orc_empenho_id=? ',@orc_empenho.id ])
    session[:id_empenho_show]= params[:id]
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_empenho }
    end
  end

  # GET /orc_empenhos/new
  # GET /orc_empenhos/new.xml


  def consulta_lancamento
    if params[:type_of].to_i == 1   #fornecedor
         
          @fichas = OrcEmpenho.find_by_sql("SELECT fc.* , (pd.fornecedor) AS fornecedor, (pd.created_at) AS data_pedido, (pd.valor_total) AS valor_si ,  (pd.codigo) AS codigo_empenho, (ep.data_chegou) AS data_empenho, (pg.codigo) AS codigo_pg , (pg.valor_pg) AS valor_pg, (pg.data_pg) AS data_pg FROM orc_fichas fc INNER JOIN orc_pedido_compras pd ON pd.orc_ficha_id = fc.id INNER JOIN orc_empenhos ep ON ep.orc_pedido_compra_id = pd.id INNER JOIN orc_pagamentos pg ON pg.orc_empenho_id = ep.id WHERE ep.interessado  like "+ "'%" + params[:search_fornecedor].to_s + "%'" + " ")
          render :update do |page|
                  page.replace_html 'lancamentos', :partial => "lancamentos"
          end
    else if params[:type_of].to_i == 4   #todas
                    @fichas = OrcEmpenho.find_by_sql("SELECT fc.* , (pd.fornecedor) AS fornecedor, (pd.created_at) AS data_pedido, (pd.valor_total) AS valor_si ,  (pd.codigo) AS codigo_empenho, (ep.data_chegou) AS data_empenho, (pg.codigo) AS codigo_pg , (pg.valor_pg) AS valor_pg, (pg.data_pg) AS data_pg FROM orc_fichas fc INNER JOIN orc_pedido_compras pd ON pd.orc_ficha_id = fc.id INNER JOIN orc_empenhos ep ON ep.orc_pedido_compra_id = pd.id INNER JOIN orc_pagamentos pg ON pg.orc_empenho_id = ep.id ")
               render :update do |page|
                  page.replace_html 'lancamentos', :partial => "lancamentos"
               end
         else if params[:type_of].to_i == 5   #dia
                    w=session[:dataI]=params[:empenho][:dataI][6,4]+'-'+params[:empenho][:dataI][3,2]+'-'+params[:empenho][:dataI][0,2]
                    w1=session[:dataF]=params[:empenho][:dataF][6,4]+'-'+params[:empenho][:dataF][3,2]+'-'+params[:empenho][:dataF][0,2]
                    w3=session[:mes]=params[:empenho][:dataF][3,2]
                     #@empenhos = OrcEmpenho.find_by_sql("SELECT * FROM orc_empenhos WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data DESC")
                      #@fichas = OrcEmpenho.find_by_sql("SELECT fcs.* , (pd.fornecedor) AS fornecedor, (pd.created_at) AS data_pedido, (pd.valor_total) AS valor_si ,  (pd.codigo) AS codigo_empenho, (ep.data_chegou) AS data_empenho, (pg.codigo) AS codigo_pg , (pg.valor_pg) AS valor_pg, (pg.data_pg) AS data_pg FROM orc_fichas fc INNER JOIN orc_pedido_compras pd ON pd.orc_ficha_id = fc.id INNER JOIN orc_empenhos ep ON ep.orc_pedido_compra_id = pd.id INNER JOIN orc_pagamentos pg ON pg.orc_empenho_id = ep.id WHERE (ep.data_chegou BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data DESC")
                      @fichas = OrcEmpenho.find_by_sql("SELECT fc.* , (pd.fornecedor) AS fornecedor, (pd.created_at) AS data_pedido, (pd.valor_total) AS valor_si ,  (pd.codigo) AS codigo_empenho, (ep.data_chegou) AS data_empenho, (pg.codigo) AS codigo_pg , (pg.valor_pg) AS valor_pg, (pg.data_pg) AS data_pg FROM orc_fichas fc INNER JOIN orc_pedido_compras pd ON pd.orc_ficha_id = fc.id INNER JOIN orc_empenhos ep ON ep.orc_pedido_compra_id = pd.id INNER JOIN orc_pagamentos pg ON pg.orc_empenho_id = ep.id WHERE (ep.data_chegou BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data DESC")
                 render :update do |page|
                    page.replace_html 'lancamentos', :partial => "lancamentos"
                 end
              end
         end
     end
  end

def ficha_lancamento

       @pedidos = OrcPedidoCompra.find(:all, :select => '(codigo)as codigo_si, (fornecedor)AS fornecedor_si, (created_at)AS data_si, (valor_total)AS valor_total_si', :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]]  )
       @ficha= OrcFicha.find(:all, :conditions => ['id = ?', params[:orc_ficha_id]])
       @empenhos = OrcEmpenho.find(:all, :select => '(codigo)AS codigo_emp , (interessado)AS fornecedor_emp,  (data_chegou)AS data_chegou_emp ,(valor_total)AS valor_total_emp', :conditions => ['ficha = ?', @ficha[0].ficha]   )
       @pagamentos = OrcPagamento.find(:all, :select => '(codigo) AS codigo_pg , (valor_pg) AS valor_pg, (data_pg) AS data_pg' , :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]])
       @lancamentos = @pedidos + @empenhos + @pagamentos
  render :partial => "lancamentos"

end


end
