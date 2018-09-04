class OrcEmpenhosController < ApplicationController
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


  def index
    @orc_empenhos = OrcEmpenho.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_empenhos }
    end
  end

  # GET /orc_empenhos/1
  # GET /orc_empenhos/1.xml
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
  def new
    @orc_empenho = OrcEmpenho.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_empenho }
    end
  end


 def new_itens
    @orc_empenho = OrcEmpenho.find(session[:news_itens])
    

  end

  # GET /orc_empenhos/1/edit
  def edit
    @orc_empenho = OrcEmpenho.find(params[:id])
  end

  # POST /orc_empenhos
  # POST /orc_empenhos.xml
  def create
      @orc_empenho = OrcEmpenho.new(params[:orc_empenho])
    respond_to do |format|
      if @orc_empenho.save
        session[:news_itens]= @orc_empenho.id

   if session[:create_new_itens]== 1
      t=0
            # salva valor_total no empenho
 #       @orc_empenho.valor_total = session[:valor_total].to_f
 #       @orc_empenho.save
             # Atualiza saldo na ficha
 #       @ficha = OrcFicha.find(:all, :conditions => ['id =?', @orc_empenho.orc_pedido_compra.orc_ficha_id])
 #       @ficha[0].saldo_empenhado = @ficha[0].saldo_empenhado + session[:valor_total]
 #       saldo= @ficha[0].saldo_atual - (@ficha[0].saldo_empenhado + session[:valor_total])- @ficha[0].saldo_reservado
 #       @ficha[0].saldo = saldo
 #       @ficha[0].save
             # Atualiza pedido_compra
 #       @pedido = OrcPedidoCompra.find(:all, :conditions => ['id =?', @orc_empenho.orc_pedido_compra_id])
 #       @pedido[0].empenhado = 1
 #       @pedido[0].save
 session[:create_new_itens]= 0
   end

        flash[:notice] = 'OrcEmpenho was successfully created.'
        format.html { redirect_to(new_itens_path) }
        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_empenho.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_empenhos/1
  # PUT /orc_empenhos/1.xml
  def update
    @orc_empenho = OrcEmpenho.find(params[:id])

    respond_to do |format|
      if @orc_empenho.update_attributes(params[:orc_empenho])
        flash[:notice] = 'OrcEmpenho was successfully updated.'
        format.html { redirect_to(@orc_empenho) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_empenho.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_empenhos/1
  # DELETE /orc_empenhos/1.xml
  def destroy
    @orc_empenho = OrcEmpenho.find(params[:id])
              # Atualiza saldo na ficha
        @ficha = OrcFicha.find(:all, :conditions => ['id =?', @orc_empenho.orc_pedido_compra.orc_ficha_id])
        @ficha[0].saldo_empenhado = @ficha[0].saldo_empenhado - session[:valor_total]
        saldo= @ficha[0].saldo_atual - (@ficha[0].saldo_empenhado - session[:valor_total])- @ficha[0].saldo_reservado
        @ficha[0].saldo = saldo
        @ficha[0].save
    
        @orc_empenho.destroy

    respond_to do |format|
      format.html { redirect_to(consulta_orc_empenhos_path) }
      format.xml  { head :ok }
    end
  end


  def dados_pedido
     @orc_pedido_compra = OrcPedidoCompra.find(:all, :conditions => ["id =?" , params[:orc_empenho_orc_pedido_compra_id]])
     render :partial => "pedido"
  end


 def create_orc_empenho_item
   session[:create_new_itens]=1
   @orc_empenho_item = OrcEmpenhoIten.new(params[:orc_empenho_item])
      @orc_empenho_item.orc_empenho_id = session[:news_itens]
            # salva items do empenho
      if @orc_empenho_item.save
        @orc_empenho_itens=OrcEmpenhoIten.find(:all, :conditions =>['orc_empenho_id =?', session[:news_itens]])

        for item in @orc_empenho_itens
          session[:soma]=session[:soma].to_f+item.total.to_f
          item.total_geral=session[:soma].to_f
          session[:valor_total] = item.total_geral
          item_empenho_id = item.orc_empenho_id
          item.save
        end
          # salva valor_total no empenho
         @orc_empenho= OrcEmpenho.find(item_empenho_id)
         @orc_empenho.valor_total= session[:valor_total]
         @orc_empenho.save

             # Atualiza saldo na ficha
        @ficha = OrcFicha.find(:all, :conditions => ['id =?', @orc_empenho.orc_pedido_compra.orc_ficha_id])
        @ficha[0].saldo_empenhado = @ficha[0].saldo_empenhado + session[:valor_total]
        saldo= @ficha[0].saldo_atual - (@ficha[0].saldo_empenhado + session[:valor_total])- @ficha[0].saldo_reservado
        @ficha[0].saldo = saldo
        @ficha[0].save
        
             # Atualiza pedido_compra
 #       @pedido = OrcPedidoCompra.find(:all, :conditions => ['id =?', @orc_empenho.orc_pedido_compra_id])
 #       @pedido[0].empenhado = 1
 #       @pedido[0].save



        render :update do |page|
          page.replace_html 'dados', :partial => "orc_empenho_itens"
          page.replace_html 'new'
        end
       end
  end



  def consulta_empenho
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
