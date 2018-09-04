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
         @empenhos = OrcEmpenho.find(:all,:conditions => ['id != 1 and interessado like ?', "%" + params[:search_fornecedor].to_s + "%"], :order => 'id DESC')
          render :update do |page|
                  page.replace_html 'empenho', :partial => "empenhos"
          end
    else if params[:type_of].to_i == 4   #todas
                 @empenhos = OrcEmpenho.find(:all,:conditions => ['id != 1'], :order => 'id DESC')
               render :update do |page|
                  page.replace_html 'empenho', :partial => "empenhos"
               end
         else if params[:type_of].to_i == 5   #dia
                    session[:dataI]=params[:empenho][:dataI][6,4]+'-'+params[:empenho][:dataI][3,2]+'-'+params[:empenho][:dataI][0,2]
                    session[:dataF]=params[:empenho][:dataF][6,4]+'-'+params[:empenho][:dataF][3,2]+'-'+params[:empenho][:dataF][0,2]
                    session[:mes]=params[:empenho][:dataF][3,2]
                     @empenhos = OrcEmpenho.find_by_sql("SELECT * FROM orc_empenhos WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data DESC")
                 render :update do |page|
                    page.replace_html 'empenho', :partial => "empenhos"
                 end
              end
         end
     end
  end

def ficha_empenho
    #consulta feita pelo orc_pedido_compra_id  que corresmpnde a ficha selelcionada
  params[:orc_empenho_orc_pedido_compra_id]

  @empenhos = OrcEmpenho.find(:all, :joins=> "INNER JOIN orc_pedido_compras ON orc_pedido_compras.id = orc_empenhos.orc_pedido_compra_id INNER JOIN orc_fichas ON orc_fichas.id =  orc_pedido_compras.orc_ficha_id", :conditions => ['orc_fichas.id= ? ', params[:orc_empenho_orc_pedido_compra_id]])
  render :partial => "empenhos"

end


end
