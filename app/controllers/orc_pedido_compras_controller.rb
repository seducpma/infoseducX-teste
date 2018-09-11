class OrcPedidoComprasController < ApplicationController
  # GET /orc_pedido_compras
  # GET /orc_pedido_compras.xml

     before_filter :load_iniciais

 def load_iniciais
        session[:current_user] = current_user.id
        @fichas = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')
        @orc_pedido_ano= OrcPedidoCompra.find(:all, :select => 'distinct(ano)')
        if current_user.has_role?('admin') or current_user.has_role?('SEDUC')
           @orc_pedido_si= OrcPedidoCompra.find(:all, :select => 'codigo', :conditions => ['ano= ? ', Time.now.year], :order => 'id DESC')
        else
           @orc_pedido_si= OrcPedidoCompra.find(:all, :select => 'codigo', :conditions => ['ano= ? and user_id =?', Time.now.year, current_user.id], :order => 'id DESC')
        end
        @orc_ficha_descricao= OrcFicha.find(:all, :select => "distinct(descricao), CONCAT( ano , ' - ',descricao       ) AS descricao_ano", :order => ' descricao ASC , ano ASC' )
 end

 def dados_ficha
    @dados_ficha=  OrcFicha.find(:all, :conditions => ['id = ?',params[:orc_pedido_compra_orc_ficha_id]])
     render :partial => "dados_fichas"
end

  def index
    @orc_pedido_compra = OrcPedidoCompra.find(:all, :conditions=> ["id != 1"], :order => 'id DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_pedido_compras }
    end
  end

  # GET /orc_pedido_compras/1
  # GET /orc_pedido_compras/1.xml
  def show
    @orc_pedido_compra = OrcPedidoCompra.find(params[:id])
    @orc_pedido_descricaos = OrcPedidoDescricao.find(:all, :conditions => ['orc_pedido_compra_id=? ',@orc_pedido_compra.id ])
    session[:id_pedido_show]= params[:id]
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_pedido_compra }
    end
  end

  # GET /orc_pedido_compras/new
  # GET /orc_pedido_compras/new.xml
  def new
    @orc_pedido_compra = OrcPedidoCompra.new


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_pedido_compra }
    end
  end

   def new_descricaos

    @orc_pedido_compra = OrcPedidoCompra.find(session[:news_decricao])

  end

  # GET /orc_pedido_compras/1/edit
  def edit
    @orc_pedido_compra = OrcPedidoCompra.find(params[:id])
    @orc_pedido_descricaos = OrcPedidoDescricao.find(:all, :conditions => ['orc_pedido_compra_id=? ',@orc_pedido_compra.id ])

  end

  # POST /orc_pedido_compras
  # POST /orc_pedido_compras.xml
  def create
    @orc_pedido_compra = OrcPedidoCompra.new(params[:orc_pedido_compra])
    #@orc_pedido_compra.codigo=(@orc_pedido_compra.id)

    respond_to do |format|
      if @orc_pedido_compra.save
        w=session[:news_decricao]= @orc_pedido_compra.id
#         @orc_pedido_descricao = OrcPedidoDescricao.find(:last, :conditions => ['orc_pedido_compra_id=?',session[:id_compra_new]])

#        @orc_pedido_compra.save
#        @orc_pedido_compra = OrcPedidoCompra.find(:all, :conditions =>['id=?', session[:id_compra_new]])
#        @orc_pedido_compra[0].valor_total = session[:soma].to_f
#        @orc_pedido_compra[0].save

       flash[:notice] = 'OrcPedidoCompra was successfully created.'
        format.html { redirect_to(new_descricaos_path) }
       else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_pedido_compra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_pedido_compras/1
  # PUT /orc_pedido_compras/1.xml
  def update
    @orc_pedido_compra = OrcPedidoCompra.find(params[:id])

    respond_to do |format|
      if @orc_pedido_compra.update_attributes(params[:orc_pedido_compra])
        flash[:notice] = 'OrcPedidoCompra was successfully updated.'
        format.html { redirect_to(@orc_pedido_compra) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_pedido_compra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_pedido_compras/1
  # DELETE /orc_pedido_compras/1.xml
  def destroy
    @orc_pedido_compra = OrcPedidoCompra.find(params[:id])
    #@orc_pedido_descricao = OrcPedidoDescricao.find( :all,:select => ['id'],:conditions => ["orc_pedido_compra_id =?" , params[:id]])
    @orc_pedido_compra.destroy
    #@orc_pedido_descricao.destroy

    respond_to do |format|
      format.html { redirect_to(home_path) }
      format.xml  { head :ok }
    end
  end

  def create_orc_pedido_descricao
      @orc_pedido_descricao = OrcPedidoDescricao.new(params[:orc_pedido_descricao])
      @orc_pedido_compra= OrcPedidoCompra.last
      @orc_pedido_compra.id
      @orc_pedido_descricao.orc_pedido_compra_id = @orc_pedido_compra.id

      if @orc_pedido_descricao.save
        @orc_pedido_descricaos=OrcPedidoDescricao.find(:all, :conditions =>['orc_pedido_compra_id =?', @orc_pedido_compra.id ])
        cont = 0
        for descricao in @orc_pedido_descricaos
          cont=cont+1
          session[:soma]=session[:soma].to_f+descricao.total.to_f
          descricao.total_geral=session[:soma].to_f
          total_geral=descricao.total_geral
          descricao.item = cont
          descricao.save
        end

         @orc_pedido_compra.valor_total = total_geral
         @orc_pedido_compra.save

        render :update do |page|
          page.replace_html 'dados', :partial => "orc_pedido_descricaos"
          page.replace_html 'new'
        end
       end
  end

  def destroy_descricao
    w=params[:id]
    @orc_pedido_descricao = OrcPedidoDescricao.find(params[:id])
    w=session[:id_pedido]= @orc_pedido_descricao.orc_pedido_compra_id

    @orc_pedido_descricao.destroy
    @orc_pedido_descricaos=OrcPedidoDescricao.find(:all, :conditions =>['orc_pedido_compra_id =?', session[:id_pedido] ])
    for descricao in @orc_pedido_descricaos
          session[:soma]=session[:soma].to_f+descricao.total.to_f
          wt=descricao.total_geral=session[:soma].to_f
          descricao.save
        end

        render :update do |page|
          page.replace_html 'dados', :partial => "orc_pedido_descricaos"
          page.replace_html 'new'
        end
  end



 def  impressao_pedido
       @orc_pedido_compra = OrcPedidoCompra.find(:all, :conditions=> ['id= ?', session[:id_pedido_show]])
       @orc_pedido_descricaos = OrcPedidoDescricao.find(:all, :conditions => ['orc_pedido_compra_id=?',session[:id_pedido_show]])
        render :layout => "impressao"
 end

  def consulta_pedido
    if params[:type_of].to_i == 1   #fornecedor
         @pedidos_compra = OrcPedidoCompra.find(:all,:conditions => ['id != 1 and fornecedor like ?', "%" + params[:search_fornecedor].to_s + "%"], :order => 'id DESC')
          render :update do |page|
                  page.replace_html 'consultapedido', :partial => "pedidos"
          end
    else if params[:type_of].to_i == 3   #sem ficha            produto(antigo)
                  @pedidos_compra = OrcPedidoCompra.find(:all,:conditions => ['orc_ficha_id is null'], :order => 'id DESC')
               render :update do |page|
                  page.replace_html 'consultapedido', :partial => "pedidos"
               end
         else if params[:type_of].to_i == 4   #todas
                      @pedidos_compra = OrcPedidoCompra.find(:all,:conditions => ['id != 1'], :order => 'id DESC')
                   render :update do |page|
                      page.replace_html 'consultapedido', :partial => "pedidos"
                   end
              end
       end
     end
end

def ficha_pedido
  @pedidos_compra = OrcPedidoCompra.find(:all, :conditions => ['orc_ficha_id = ? and id != 1', params[:orc_pedido_compra_orc_ficha_id]], :order => 'id DESC')
  session[:ficha_id]=  params[:orc_pedido_compra_orc_ficha_id]
   @ficha = OrcFicha.find(:all, :conditions =>['id = ? ', session[:ficha_id]])
   
  session[:ficha]=1
 
   render :partial => "pedidos"

end

  def pedido_ano
   @pedidos_compra = OrcPedidoCompra.find(:all, :conditions => ['ano= ? and id != 1', params[:orc_pedido_compra_ano]], :order => 'id DESC')
   render :partial => "pedidos"
  end


  def pedido_codigo
   @pedidos_compra = OrcPedidoCompra.find(:all, :conditions => ['codigo= ? and id != 1', params[:orc_pedido_compra_codigo]], :order => 'id DESC')
   render :partial => "pedidos"
  end

end
