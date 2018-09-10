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
       @ficha= OrcFicha.find(:all, :joins=> 'INNER JOIN orc_empenhos ON orc_empenhos.ficha = orc_fichas.ficha',:conditions => ['interessado like ?', "%" + params[:search_fornecedor].to_s + "%"], :order => 'id DESC')
       @pedidos = OrcPedidoCompra.find(:all, :joins => 'JOIN orc_fichas fichas ON orc_pedido_compras.orc_ficha_id=fichas.id JOIN orc_empenhos em ON em.orc_pedido_compra_id=orc_pedido_compras.id', :select => '(orc_pedido_compras.created_at)AS data_lanc, (fichas.ficha) AS rel_ficha,"S.I." as rel_tipo, (orc_pedido_compras.codigo)as rel_codigo, (orc_pedido_compras.fornecedor)AS rel_interessado, (date_format(orc_pedido_compras.created_at,"%d/%m/%Y"))AS rel_data, (orc_pedido_compras.valor_total)AS rel_valor_si, (em.valor_total) AS rel_valor_em, "-o-"AS rel_valor_op',   :conditions => ['orc_pedido_compras.fornecedor like ?', "%" + params[:search_fornecedor].to_s + "%"])
       @empenhos = OrcEmpenho.find(:all, :select => '(data_chegou)AS data_lanc, ficha AS rel_ficha, "EMP." as rel_tipo, (codigo)AS rel_codigo , (interessado)AS rel_interessado,  (date_format(data_chegou,"%d/%m/%Y")) AS rel_data, "-o-"AS rel_valor_si, (valor_total)AS rel_valor_em, "-o-"AS rel_valor_op',  :conditions => ['orc_empenhos.interessado like ?', "%" + params[:search_fornecedor].to_s + "%"])
       @pagamentos = OrcPagamento.find(:all, :joins => 'JOIN orc_empenhos em ON em.id=orc_pagamentos.orc_empenho_id', :select => ' (orc_pagamentos.data_pg)AS data_lanc, (orc_pagamentos.ficha)as rel_ficha, "O.P." as rel_tipo, (orc_pagamentos.codigo) AS rel_codigo, em.interessado AS rel_interessado,  (date_format(orc_pagamentos.data_pg,"%d/%m/%Y"))AS rel_data,"-o-"AS rel_valor_si, (em.valor_total) AS rel_valor_em, (valor_pg) AS rel_valor_op' , :conditions => ['em.interessado like ?', "%" + params[:search_fornecedor].to_s + "%"])
       @lancamentos = (@pedidos + @empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}

                  render :update do |page|
                  page.replace_html 'lancamentos', :partial => "lancamentos"
          end
    else if params[:type_of].to_i == 4   #todas
       @ficha= OrcFicha.find(:all, :conditions => ['ano = ?', Time.now.year] )
       @pedidos = OrcPedidoCompra.find(:all, :joins => 'JOIN orc_fichas fichas ON orc_pedido_compras.orc_ficha_id=fichas.id JOIN orc_empenhos em ON em.orc_pedido_compra_id=orc_pedido_compras.id', :select => '(orc_pedido_compras.created_at)AS data_lanc, (fichas.ficha) AS rel_ficha,"S.I." as rel_tipo, (orc_pedido_compras.codigo)as rel_codigo, (orc_pedido_compras.fornecedor)AS rel_interessado, (date_format(orc_pedido_compras.created_at,"%d/%m/%Y"))AS rel_data, (orc_pedido_compras.valor_total)AS rel_valor_si, (em.valor_total) AS rel_valor_em, "-o-"AS rel_valor_op',  :conditions => ['year(orc_pedido_compras.created_at) = ?', Time.now.year], :order =>'data'  )
       @empenhos = OrcEmpenho.find(:all, :select => '(data_chegou)AS data_lanc, ficha AS rel_ficha, "EMP." as rel_tipo, (codigo)AS rel_codigo , (interessado)AS rel_interessado,  (date_format(data_chegou,"%d/%m/%Y")) AS rel_data, "-o-"AS rel_valor_si, (valor_total)AS rel_valor_em, "-o-"AS rel_valor_op', :conditions => ['year(data_chegou) = ?', Time.now.year], :order =>'data'  )
       @pagamentos = OrcPagamento.find(:all, :joins => 'JOIN orc_empenhos em ON em.id=orc_pagamentos.orc_empenho_id', :select => ' (orc_pagamentos.data_pg)AS data_lanc, (orc_pagamentos.ficha)as rel_ficha, "O.P." as rel_tipo, (orc_pagamentos.codigo) AS rel_codigo, em.interessado AS rel_interessado,  (date_format(orc_pagamentos.data_pg,"%d/%m/%Y"))AS rel_data,"-o-"AS rel_valor_si, (em.valor_total) AS rel_valor_em, (valor_pg) AS rel_valor_op' ,  :conditions => ['year(orc_pagamentos.data_pg) = ?', Time.now.year], :order =>'data'  )
       @lancamentos = (@pedidos + @empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}


               render :update do |page|
                  page.replace_html 'lancamentos', :partial => "lancamentos"
               end
         else if params[:type_of].to_i == 5   #data
                    session[:dataI]=params[:empenho][:dataI][6,4]+'-'+params[:empenho][:dataI][3,2]+'-'+params[:empenho][:dataI][0,2]
                    session[:dataF]=params[:empenho][:dataF][6,4]+'-'+params[:empenho][:dataF][3,2]+'-'+params[:empenho][:dataF][0,2]
                    session[:mes]=params[:empenho][:dataF][3,2]
                     @ficha= OrcFicha.find(:all, :joins=> 'INNER JOIN orc_empenhos ON orc_empenhos.ficha = orc_fichas.ficha',:conditions => ['data_chegou BETWEEN ? AND ?',session[:dataI],session[:dataF]], :order => 'id DESC')
                     @pedidos = OrcPedidoCompra.find(:all, :joins => 'JOIN orc_fichas fichas ON orc_pedido_compras.orc_ficha_id=fichas.id JOIN orc_empenhos em ON em.orc_pedido_compra_id=orc_pedido_compras.id', :select => '(orc_pedido_compras.created_at)AS data_lanc, (fichas.ficha) AS rel_ficha,"S.I." as rel_tipo, (orc_pedido_compras.codigo)as rel_codigo, (orc_pedido_compras.fornecedor)AS rel_interessado, (date_format(orc_pedido_compras.created_at,"%d/%m/%Y"))AS rel_data, (orc_pedido_compras.valor_total)AS rel_valor_si, (em.valor_total) AS rel_valor_em, "-o-"AS rel_valor_op',  :conditions => ['orc_pedido_compras.created_at BETWEEN ? AND ?',session[:dataI],session[:dataF]], :order =>'data'  )
                     @empenhos = OrcEmpenho.find(:all, :select => '(data_chegou)AS data_lanc, ficha AS rel_ficha, "EMP." as rel_tipo, (codigo)AS rel_codigo , (interessado)AS rel_interessado,  (date_format(data_chegou,"%d/%m/%Y")) AS rel_data, "-o-"AS rel_valor_si, (valor_total)AS rel_valor_em, "-o-"AS rel_valor_op',:conditions => ['data_chegou BETWEEN ? AND ?',session[:dataI],session[:dataF]], :order => 'data'   )
                     @pagamentos = OrcPagamento.find(:all, :joins => 'JOIN orc_empenhos em ON em.id=orc_pagamentos.orc_empenho_id', :select => ' (orc_pagamentos.data_pg)AS data_lanc, (orc_pagamentos.ficha)as rel_ficha, "O.P." as rel_tipo, (orc_pagamentos.codigo) AS rel_codigo, em.interessado AS rel_interessado,  (date_format(orc_pagamentos.data_pg,"%d/%m/%Y"))AS rel_data,"-o-"AS rel_valor_si, (em.valor_total) AS rel_valor_em, (valor_pg) AS rel_valor_op' ,  :conditions => ['orc_pagamentos.data_pg BETWEEN ? AND ?',session[:dataI],session[:dataF]], :order => 'data')
                     @lancamentos = (@pedidos + @empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}

                 render :update do |page|
                    page.replace_html 'lancamentos', :partial => "lancamentos"
                 end
              end
         end
     end
  end

def consultaSI_lancamento
    if params[:type_of].to_i == 1   #fornecedor
       @ficha= OrcFicha.find(:all, :joins=> 'INNER JOIN orc_empenhos ON orc_empenhos.ficha = orc_fichas.ficha',:conditions => ['interessado like ?', "%" + params[:search_fornecedor].to_s + "%"], :order => 'id DESC')
       #@pedidos = OrcPedidoCompra.find(:all, :joins => 'JOIN orc_fichas fichas ON orc_pedido_compras.orc_ficha_id=fichas.id JOIN orc_empenhos em ON em.orc_pedido_compra_id=orc_pedido_compras.id', :select => '(orc_pedido_compras.created_at)AS data_lanc, (fichas.ficha) AS rel_ficha,"S.I." as rel_tipo, (orc_pedido_compras.codigo)as rel_codigo, (orc_pedido_compras.fornecedor)AS rel_interessado, (date_format(orc_pedido_compras.created_at,"%d/%m/%Y"))AS rel_data, (orc_pedido_compras.valor_total)AS rel_valor_si, (em.valor_total) AS rel_valor_em, "-o-"AS rel_valor_op',   :conditions => ['orc_pedido_compras.fornecedor like ?', "%" + params[:search_fornecedor].to_s + "%"])
       @empenhos = OrcEmpenho.find(:all, :select => '(data_chegou)AS data_lanc, ficha AS rel_ficha, "EMP." as rel_tipo, (codigo)AS rel_codigo , (interessado)AS rel_interessado,  (date_format(data_chegou,"%d/%m/%Y")) AS rel_data, "-o-"AS rel_valor_si, (valor_total)AS rel_valor_em, "-o-"AS rel_valor_op',  :conditions => ['orc_empenhos.interessado like ?', "%" + params[:search_fornecedor].to_s + "%"])
       @pagamentos = OrcPagamento.find(:all, :joins => 'JOIN orc_empenhos em ON em.id=orc_pagamentos.orc_empenho_id', :select => ' (orc_pagamentos.data_pg)AS data_lanc, (orc_pagamentos.ficha)as rel_ficha, "O.P." as rel_tipo, (orc_pagamentos.codigo) AS rel_codigo, em.interessado AS rel_interessado,  (date_format(orc_pagamentos.data_pg,"%d/%m/%Y"))AS rel_data,"-o-"AS rel_valor_si, (em.valor_total) AS rel_valor_em, (valor_pg) AS rel_valor_op' , :conditions => ['em.interessado like ?', "%" + params[:search_fornecedor].to_s + "%"])
       @lancamentos = (@empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}

                  render :update do |page|
                  page.replace_html 'lancamentos', :partial => "lancamentosSI"
          end
    else if params[:type_of].to_i == 4   #todas
       @ficha= OrcFicha.find(:all, :conditions => ['ano = ?', Time.now.year] )
       #@pedidos = OrcPedidoCompra.find(:all, :joins => 'JOIN orc_fichas fichas ON orc_pedido_compras.orc_ficha_id=fichas.id JOIN orc_empenhos em ON em.orc_pedido_compra_id=orc_pedido_compras.id', :select => '(orc_pedido_compras.created_at)AS data_lanc, (fichas.ficha) AS rel_ficha,"S.I." as rel_tipo, (orc_pedido_compras.codigo)as rel_codigo, (orc_pedido_compras.fornecedor)AS rel_interessado, (date_format(orc_pedido_compras.created_at,"%d/%m/%Y"))AS rel_data, (orc_pedido_compras.valor_total)AS rel_valor_si, (em.valor_total) AS rel_valor_em, "-o-"AS rel_valor_op',  :conditions => ['year(orc_pedido_compras.created_at) = ?', Time.now.year], :order =>'data'  )
       @empenhos = OrcEmpenho.find(:all, :select => '(data_chegou)AS data_lanc, ficha AS rel_ficha, "EMP." as rel_tipo, (codigo)AS rel_codigo , (interessado)AS rel_interessado,  (date_format(data_chegou,"%d/%m/%Y")) AS rel_data, "-o-"AS rel_valor_si, (valor_total)AS rel_valor_em, "-o-"AS rel_valor_op', :conditions => ['year(data_chegou) = ?', Time.now.year], :order =>'data'  )
       @pagamentos = OrcPagamento.find(:all, :joins => 'JOIN orc_empenhos em ON em.id=orc_pagamentos.orc_empenho_id', :select => ' (orc_pagamentos.data_pg)AS data_lanc, (orc_pagamentos.ficha)as rel_ficha, "O.P." as rel_tipo, (orc_pagamentos.codigo) AS rel_codigo, em.interessado AS rel_interessado,  (date_format(orc_pagamentos.data_pg,"%d/%m/%Y"))AS rel_data,"-o-"AS rel_valor_si, (em.valor_total) AS rel_valor_em, (valor_pg) AS rel_valor_op' ,  :conditions => ['year(orc_pagamentos.data_pg) = ?', Time.now.year], :order =>'data'  )
       @lancamentos = (@empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}


               render :update do |page|
                  page.replace_html 'lancamentos', :partial => "lancamentosSI"
               end
         else if params[:type_of].to_i == 5   #data
                    session[:dataI]=params[:empenho][:dataI][6,4]+'-'+params[:empenho][:dataI][3,2]+'-'+params[:empenho][:dataI][0,2]
                    session[:dataF]=params[:empenho][:dataF][6,4]+'-'+params[:empenho][:dataF][3,2]+'-'+params[:empenho][:dataF][0,2]
                    session[:mes]=params[:empenho][:dataF][3,2]
                     @ficha= OrcFicha.find(:all, :joins=> 'INNER JOIN orc_empenhos ON orc_empenhos.ficha = orc_fichas.ficha',:conditions => ['data_chegou BETWEEN ? AND ?',session[:dataI],session[:dataF]], :order => 'id DESC')
                     #@pedidos = OrcPedidoCompra.find(:all, :joins => 'JOIN orc_fichas fichas ON orc_pedido_compras.orc_ficha_id=fichas.id JOIN orc_empenhos em ON em.orc_pedido_compra_id=orc_pedido_compras.id', :select => '(orc_pedido_compras.created_at)AS data_lanc, (fichas.ficha) AS rel_ficha,"S.I." as rel_tipo, (orc_pedido_compras.codigo)as rel_codigo, (orc_pedido_compras.fornecedor)AS rel_interessado, (date_format(orc_pedido_compras.created_at,"%d/%m/%Y"))AS rel_data, (orc_pedido_compras.valor_total)AS rel_valor_si, (em.valor_total) AS rel_valor_em, "-o-"AS rel_valor_op',  :conditions => ['orc_pedido_compras.created_at BETWEEN ? AND ?',session[:dataI],session[:dataF]], :order =>'data'  )
                     @empenhos = OrcEmpenho.find(:all, :select => '(data_chegou)AS data_lanc, ficha AS rel_ficha, "EMP." as rel_tipo, (codigo)AS rel_codigo , (interessado)AS rel_interessado,  (date_format(data_chegou,"%d/%m/%Y")) AS rel_data, "-o-"AS rel_valor_si, (valor_total)AS rel_valor_em, "-o-"AS rel_valor_op',:conditions => ['data_chegou BETWEEN ? AND ?',session[:dataI],session[:dataF]], :order => 'data'   )
                     @pagamentos = OrcPagamento.find(:all, :joins => 'JOIN orc_empenhos em ON em.id=orc_pagamentos.orc_empenho_id', :select => ' (orc_pagamentos.data_pg)AS data_lanc, (orc_pagamentos.ficha)as rel_ficha, "O.P." as rel_tipo, (orc_pagamentos.codigo) AS rel_codigo, em.interessado AS rel_interessado,  (date_format(orc_pagamentos.data_pg,"%d/%m/%Y"))AS rel_data,"-o-"AS rel_valor_si, (em.valor_total) AS rel_valor_em, (valor_pg) AS rel_valor_op' ,  :conditions => ['orc_pagamentos.data_pg BETWEEN ? AND ?',session[:dataI],session[:dataF]], :order => 'data')
                     @lancamentos = ( @empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}

                 render :update do |page|
                    page.replace_html 'lancamentos', :partial => "lancamentosSI"
                 end
              end
         end
     end
  end



def ficha_lancamento
       @ficha= OrcFicha.find(:all, :conditions => ['id = ?', params[:orc_ficha_id]])
       @pedidos = OrcPedidoCompra.find(:all, :joins => 'JOIN orc_fichas fichas ON orc_pedido_compras.orc_ficha_id=fichas.id JOIN orc_empenhos em ON em.orc_pedido_compra_id=orc_pedido_compras.id', :select => '(orc_pedido_compras.created_at)AS data_lanc, (fichas.ficha) AS rel_ficha,"S.I." as rel_tipo, (orc_pedido_compras.codigo)as rel_codigo, (orc_pedido_compras.fornecedor)AS rel_interessado, (date_format(orc_pedido_compras.created_at,"%d/%m/%Y"))AS rel_data, (orc_pedido_compras.valor_total)AS rel_valor_si, (em.valor_total) AS rel_valor_em, "-o-"AS rel_valor_op',  :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]], :order =>'data')
       @empenhos = OrcEmpenho.find(:all, :select => '(data_chegou)AS data_lanc, ficha AS rel_ficha, "EMP." as rel_tipo, (codigo)AS rel_codigo , (interessado)AS rel_interessado,  (date_format(data_chegou,"%d/%m/%Y")) AS rel_data, "-o-"AS rel_valor_si, (valor_total)AS rel_valor_em, "-o-"AS rel_valor_op', :conditions => ['ficha = ?', @ficha[0].ficha], :order => 'data'   )
       @pagamentos = OrcPagamento.find(:all, :joins => 'JOIN orc_empenhos em ON em.id=orc_pagamentos.orc_empenho_id', :select => ' (orc_pagamentos.data_pg)AS data_lanc, (orc_pagamentos.ficha)as rel_ficha, "O.P." as rel_tipo, (orc_pagamentos.codigo) AS rel_codigo, em.interessado  AS rel_interessado,  (date_format(orc_pagamentos.data_pg,"%d/%m/%Y"))AS rel_data,"-o-"AS rel_valor_si, (em.valor_total) AS rel_valor_em, (valor_pg) AS rel_valor_op' , :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]], :order => 'data')
       @lancamentos = (@pedidos + @empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}
#       @pedidos = OrcPedidoCompra.find(:all, :select => '(created_at)AS data_lanc, (codigo)as codigo_si, (fornecedor)AS fornecedor_si, (date_format(created_at,"%d/%m/%Y"))AS data_si, (valor_total)AS valor_si, " "AS codigo_emp, " "AS interessado_emp, " "AS data_chegou_emp ," "AS valor_total_emp, " " AS codigo_pg , " " AS valor_pg, " " AS data1 ',  :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]], :order =>'data_si'  )
#       @ficha= OrcFicha.find(:all, :conditions => ['id = ?', params[:orc_ficha_id]])
#       @empenhos = OrcEmpenho.find(:all, :select => ' (data_chegou)AS data_lanc, " "AS codigo_si, " "AS fornecedor_si, " "AS data_si, " "AS valor_si, (codigo)AS codigo_emp , (interessado)AS interessado_emp,  (date_format(data_chegou,"%d/%m/%Y")) AS data_chegou_emp ,(valor_total)AS valor_total_emp, " "AS valor_total_emp, " " AS codigo_pg , " " AS valor_pg, " " AS data1 ', :conditions => ['ficha = ?', @ficha[0].ficha], :order => 'data_chegou_emp'   )
#       @pagamentos = OrcPagamento.find(:all, :select => ' (data_pg)AS data_lanc," "AS codigo_si, " "AS fornecedor_si, " "AS data_si, " "AS valor_si," "AS codigo_emp, " "AS interessado_emp, " "AS data_chegou_emp ," "AS valor_total_emp, (codigo) AS codigo_pg , (valor_pg) AS valor_pg,  (date_format(data_pg,"%d/%m/%Y"))AS data1' , :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]], :order => 'data1')
#       @lancamentos = (@pedidos + @empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}
       render :partial => "lancamentos"
end

def ficha_lancamentoSI
       @ficha= OrcFicha.find(:all, :conditions => ['id = ?', params[:orc_ficha_id]])
      # @pedidos = OrcPedidoCompra.find(:all, :joins => 'JOIN orc_fichas fichas ON orc_pedido_compras.orc_ficha_id=fichas.id JOIN orc_empenhos em ON em.orc_pedido_compra_id=orc_pedido_compras.id', :select => '(orc_pedido_compras.created_at)AS data_lanc, (fichas.ficha) AS rel_ficha,"S.I." as rel_tipo, (orc_pedido_compras.codigo)as rel_codigo, (orc_pedido_compras.fornecedor)AS rel_interessado, (date_format(orc_pedido_compras.created_at,"%d/%m/%Y"))AS rel_data, (orc_pedido_compras.valor_total)AS rel_valor_si, (em.valor_total) AS rel_valor_em, "-o-"AS rel_valor_op',  :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]], :order =>'data')
                                                                                        @empenhos = OrcEmpenho.find(:all, :select => '(data_chegou)AS data_lanc, ficha AS rel_ficha, "EMP." as rel_tipo, (codigo)AS rel_codigo , (interessado)AS rel_interessado,  (date_format(data_chegou,"%d/%m/%Y")) AS rel_data, "-o-"AS rel_valor_si, (valor_total)AS rel_valor_em, "-o-"AS rel_valor_op', :conditions => ['ficha = ?', @ficha[0].ficha], :order => 'data'   )
       @pagamentos = OrcPagamento.find(:all, :joins => 'JOIN orc_empenhos em ON em.id=orc_pagamentos.orc_empenho_id', :select => ' (orc_pagamentos.data_pg)AS data_lanc, (orc_pagamentos.ficha)as rel_ficha, "O.P." as rel_tipo, (orc_pagamentos.codigo) AS rel_codigo, em.interessado  AS rel_interessado,  (date_format(orc_pagamentos.data_pg,"%d/%m/%Y"))AS rel_data,"-o-"AS rel_valor_si, (em.valor_total) AS rel_valor_em, (valor_pg) AS rel_valor_op' , :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]], :order => 'data')
       @lancamentos = (@empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}
#       @pedidos = OrcPedidoCompra.find(:all, :select => '(created_at)AS data_lanc, (codigo)as codigo_si, (fornecedor)AS fornecedor_si, (date_format(created_at,"%d/%m/%Y"))AS data_si, (valor_total)AS valor_si, " "AS codigo_emp, " "AS interessado_emp, " "AS data_chegou_emp ," "AS valor_total_emp, " " AS codigo_pg , " " AS valor_pg, " " AS data1 ',  :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]], :order =>'data_si'  )
#       @ficha= OrcFicha.find(:all, :conditions => ['id = ?', params[:orc_ficha_id]])
#       @empenhos = OrcEmpenho.find(:all, :select => ' (data_chegou)AS data_lanc, " "AS codigo_si, " "AS fornecedor_si, " "AS data_si, " "AS valor_si, (codigo)AS codigo_emp , (interessado)AS interessado_emp,  (date_format(data_chegou,"%d/%m/%Y")) AS data_chegou_emp ,(valor_total)AS valor_total_emp, " "AS valor_total_emp, " " AS codigo_pg , " " AS valor_pg, " " AS data1 ', :conditions => ['ficha = ?', @ficha[0].ficha], :order => 'data_chegou_emp'   )
#       @pagamentos = OrcPagamento.find(:all, :select => ' (data_pg)AS data_lanc," "AS codigo_si, " "AS fornecedor_si, " "AS data_si, " "AS valor_si," "AS codigo_emp, " "AS interessado_emp, " "AS data_chegou_emp ," "AS valor_total_emp, (codigo) AS codigo_pg , (valor_pg) AS valor_pg,  (date_format(data_pg,"%d/%m/%Y"))AS data1' , :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]], :order => 'data1')
#       @lancamentos = (@pedidos + @empenhos + @pagamentos).sort_by{|e| e[:data_lanc]}
       render :partial => "lancamentosSI"
end


end
