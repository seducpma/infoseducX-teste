class OrcPedidoComprasController < ApplicationController
  # GET /orc_pedido_compras
  # GET /orc_pedido_compras.xml

     before_filter :load_iniciais

 def load_iniciais
        session[:current_user] = current_user.id
        @fichas = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')
        @atas = OrcAta.find(:all, :conditions => ["DATE_ADD(data, INTERVAL 1 YEAR) > NOW()" ])
        @orc_pedido_ano= OrcPedidoCompra.find(:all, :select => 'distinct(ano)')
        if current_user.has_role?('admin') or current_user.has_role?('SEDUC')
           @orc_pedido_si= OrcPedidoCompra.find(:all, :select => 'codigo', :conditions => ['ano= ? ', Time.now.year], :order => 'codigo DESC')
        else if (current_user.login == 'merenda.adriana')or (current_user.login == 'merenda.fabiana')or (current_user.login == 'merenda.claudete')  #excessão dos usuáriosda merenda
              @orc_pedido_si= OrcPedidoCompra.find(:all, :select => 'codigo', :conditions => ['ano= ? and (user_id = 523  or user_id = 525 or user_id=528)', Time.now.year], :order => 'codigo DESC')

             else if (current_user.login == 'adriana_turquiai')or (current_user.login == 'seduc.celso') #excessão dos usuáriosda merenda
              @orc_pedido_si= OrcPedidoCompra.find(:all, :select => 'codigo', :conditions => ['ano= ? and (user_id = 196  or user_id = 524) ', Time.now.year], :order => 'codigo DESC')

                  else
                     @orc_pedido_si= OrcPedidoCompra.find(:all, :select => 'codigo', :conditions => ['ano= ? and user_id = ?', Time.now.year, current_user.id], :order => 'codigo DESC')
                     #@orc_pedido_si= OrcPedidoCompra.find(:all, :select => 'codigo', :conditions => ['ano= ? and user_id =?', Time.now.year, current_user.id], :order => 'id DESC')  acertar  USER-ID
                   end
             end
        end
        @orc_ficha_descricao= OrcFicha.find(:all, :select => "distinct(descricao), CONCAT( ano , ' - ',descricao       ) AS descricao_ano", :order => ' descricao ASC , ano ASC' )
 end

 def dados_ficha
    @dados_ficha=  OrcFicha.find(:all, :conditions => ['id = ?',params[:orc_pedido_compra_orc_ficha_id]])
     render :partial => "dados_fichas"
end

  def index
    #@orc_pedido_compra = OrcPedidoCompra.find(:all, :order => 'id DESC')
    @orc_pedido_compra= OrcPedidoCompra.find_by_sql("SELECT opc . * FROM `orc_pedido_compras` opc LEFT JOIN orc_empenhos oe ON oe.orc_pedido_compra_id = opc.id WHERE oe.id IS NULL ")
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
    session[:ata_id]=@orc_pedido_compra.ata_id
    session[:compra_id]=@orc_pedido_compra.id
       @ata_itens = OrcAtaIten.find(:all, :conditions => ['orc_ata_id =?',session[:ata_id]])

    #session[:show_destino]=1
  end

   def verifica_ata_si

       session[:ata]=params[:orc_pedido_compra_ata_id]
       session[:sem_ata]=1

   end


  # GET /orc_pedido_compras/1/edit
  def edit
    @orc_pedido_compra = OrcPedidoCompra.find(params[:id])
    @orc_pedido_descricaos = OrcPedidoDescricao.find(:all, :conditions => ['orc_pedido_compra_id=? ',@orc_pedido_compra.id ])
    session[:news_decricao]= @orc_pedido_compra.id
  end

  def destino

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
         @orc_pedido_compra.user_id = current_user.id

       @orc_pedido_compra.save
        session[:news_itens]= @orc_pedido_compra.id
       #? @ficha = OrcFicha.find(:all, :conditions => ['id =?',  session[:ficha_id]])
       # @orc_empenho.ficha_id=@ficha[0].id
       # @orc_empenho.ficha=@ficha[0].ficha
       # @orc_empenho.save
          if session[:create_new_itens]== 1
             session[:create_new_itens]= 0
          end
          pedido=@orc_pedido_compra.id
          @pedido = OrcPedidoCompra.find(:all, :conditions =>['id=?',pedido])
           if  session[:sem_ata]==1
               @itens_pedido = OrcAtaIten.find(:all, :conditions => ["orc_ata_id =?" , session[:ata]])
                  item=0
                  for descricao_compra in @itens_pedido
                      valor_item=descricao_compra.total
                      item = item+1
                      session[:create_new_itens]=1
                      @orc_pedido_descricao = OrcPedidoDescricao.new(params[pedido])
                      @orc_pedido_descricao.item = item
                      @orc_pedido_descricao.orc_pedido_compra_id = pedido
                      @orc_pedido_descricao.orc_ata_item_id= descricao_compra.id
                      @orc_pedido_descricao.quantidade = descricao_compra.saldo
                      @orc_pedido_descricao.medida = descricao_compra.medida
                      @orc_pedido_descricao.saldo = descricao_compra.saldo
                      @orc_pedido_descricao.descricao = descricao_compra.descricao
                      @orc_pedido_descricao.unitario = descricao_compra.unitario
                      @orc_pedido_descricao.total = descricao_compra.total
                      @orc_pedido_descricao.total_geral = descricao_compra.total_geral
                      session[:valor_total] = @orc_pedido_descricao.total_geral
                      @orc_pedido_descricao.save
                               # salva valor total no pedido_compra
                      @orc_pedido_compra.valor_total= session[:valor_total]
                      @orc_pedido_compra.save
                              # Atualiza saldo na ata


                   end


               session[:emp_id]= @pedido[0].id
               session[:sem_ata]= 0
             end

        flash[:notice] = 'SALVO COM SUCESSO.'
        #format.html { redirect_to(new_itens_path) }
         format.html { redirect_to( {:action => "edit", :id =>@pedido[0].id} ) }
         format.html { redirect_to( @pedido) }
         format.xml  { render :xml =>  @pedido, :status => :created, :location =>  @pedido }

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
    session[:destino]= params[:destino]

    if session[:show_destino]==1
        respond_to do |format|
          if @orc_pedido_compra.update_attributes(params[:orc_pedido_compra])
            flash[:notice] = 'SALVO COM SUCESSO.'
            format.html { redirect_to( {:action => "destino", :id =>@orc_pedido_compra.id} ) }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @orc_pedido_compra.errors, :status => :unprocessable_entity }
          end
        end
       session[:show_destino]=0
    else
        respond_to do |format|
          if @orc_pedido_compra.update_attributes(params[:orc_pedido_compra])
#>>>>>>>>
 #             @ata = OrcAta.find(:all, :conditions=>['id =?', @orc_pedido_compra.ata_id])
 #             @itens_pedido = OrcPedidoDescricao.find(:all, :conditions=>['orc_pedido_compra_id=?',@orc_pedido_compra.id ])
 #             if !@orc_pedido_compra.ata_id.nil?
  #                    for descricao_compra in @itens_pedido
 #                        @oc_ata_item = OrcAtaIten.find(descricao_compra.orc_ata_item_id)
 #                        saldo_anterior= @oc_ata_item.saldo
 #                        quantidade= descricao_compra.quantidade
 #                        saldo_atualizado= saldo_anterior- quantidade
 #                        @oc_ata_item.saldo =  saldo_atualizado
 #                        descricao_compra.saldo = saldo_atualizado
 #                        @oc_ata_item.save
 ##                        descricao_compra.save
 ##                     end
 #             end
#<<<<<<<

      if params[:cancela].to_i == 1
                @orc_pedido_compra.cancelado=1
                @orc_pedido_compra.save
      end
            flash[:notice] = 'SALVO COM SUCESSO.'
            format.html { redirect_to(@orc_pedido_compra) }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @orc_pedido_compra.errors, :status => :unprocessable_entity }
          end
        end
       session[:show_destino]=0
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


      @orc_pedido_compra= OrcPedidoCompra.find(session[:news_decricao])
      #@orc_pedido_compra.id
      @orc_pedido_descricao.orc_pedido_compra_id = session[:news_decricao]

      if @orc_pedido_descricao.save
        @orc_pedido_descricaos=OrcPedidoDescricao.find(:all, :conditions =>['orc_pedido_compra_id =?', session[:news_decricao] ])
        session[:quant_item]= @orc_pedido_descricao.quantidade
        cont = 0
        for descricao in @orc_pedido_descricaos
          cont=cont+1
          session[:soma]=session[:soma].to_f+descricao.total.to_f
          descricao.total_geral=session[:soma].to_f
          total_geral=descricao.total_geral
          descricao.item = cont
          descricao.orc_ata_item_id=@orc_pedido_descricaos[0].orc_ata_item_id
          descricao.save
        end

         @orc_pedido_compra.valor_total = total_geral
         #w=session[:ata]= @orc_pedido_compra.ata
         @orc_pedido_compra.save
           #atualização saldo ata
          #if !session[:ata].empty?
          #  @ata = OrcAta.find(:all, :conditions=>['codigo =?',session[:ata]])
          #  @ata_itens= OrcAtaIten.find(:all, :conditions=>['orc_ata_id=?', @ata[0].id])
          #  for item in @ata_itens
          #      w1=session[:saldo_anterior]= item.saldo
          #      w2=item.saldo = session[:saldo_anterior] - session[:quant_item]
#t=#0
         #       item.save
         #   end

         # end


        render :update do |page|
          page.replace_html 'dados', :partial => "orc_pedido_descricaos"
          page.replace_html 'new'
        end
       end
  end

  def destroy_descricao
    
    @orc_pedido_descricao = OrcPedidoDescricao.find(params[:id])
    session[:id_pedido]= @orc_pedido_descricao.orc_pedido_compra_id

    @orc_pedido_descricao.destroy
    @orc_pedido_descricaos=OrcPedidoDescricao.find(:all, :conditions =>['orc_pedido_compra_id =?', session[:id_pedido] ])
    for descricao in @orc_pedido_descricaos
          session[:soma]=session[:soma].to_f+descricao.total.to_f
          wt=descricao.total_geral=session[:soma].to_f
          descricao.save
        end
     @pedido = OrcPedidoCompra.find(:all, :conditions => ['id = ?', session[:id_pedido]])
     @pedido[0].valor_total= session[:soma].to_f
     @pedido[0].save
                    respond_to do |format|

                       flash[:notice] = 'ALTERADO COM SUCESSO.'
                                format.html { redirect_to( {:action => "edit", :id => @pedido[0].id} ) }
                                format.html { redirect_to( @pedido) }
                                format.xml  { render :xml =>  @pedido, :status => :created, :location =>  @pedido }
                end
   #     render :update do |page|
   #       page.replace_html 'dados', :partial => "orc_pedido_descricaos"
   #       page.replace_html 'new'
   #     end
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
    else if params[:type_of].to_i == 3   #sem empenho            produto(antigo)
                  #@pedidos_compra = OrcPedidoCompra.find(:all, :joins=> 'JOIN orc_empenhos ON orc_pedido_compras.id  = orc_empenhos.orc_pedido_compra_id', :conditions => ['orc_pedido_compra_id NOT IN ( SELECT orc_pedido_compra_id FROM orc_empenhos )'], :order => 'id DESC')
                  @pedidos_compra = OrcPedidoCompra.find_by_sql("SELECT opc . * FROM `orc_pedido_compras` opc LEFT JOIN orc_empenhos oe ON oe.orc_pedido_compra_id = opc.id WHERE oe.id IS NULL ")
               render :update do |page|
                  page.replace_html 'consultapedido', :partial => "pedidos"
               end
         else if params[:type_of].to_i == 4   #objetivo
                      #@pedidos_compra = OrcPedidoCompra.find(:all,:conditions => ['id != 1'], :order => 'id DESC')
                      @pedidos_compra = OrcPedidoCompra.find(:all,:conditions => ['id != 1 and objetivo like ?', "%" + params[:search_objetivo].to_s + "%"], :order => 'id DESC')
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

  def ja_existe
       if OrcPedidoCompra.find_by_codigo(params[:orc_pedido_compra_codigo]) then
        render :partial => "ja_existe"
        
        else
         render :nothing => true
       end
  end


   def si_selecionados
      session[:pedido_ids]=params[:pedido_ids]
      #@chamados = Chamado.find(params[:chamado_ids], :joins => "LEFT JOIN "+session[:base]+".unidades uni ON uni.id = chamados.unidade_id")
      #@orc_pedido_compra= OrcPedidoCompra.find_by_sql("SELECT opc . * FROM `orc_pedido_compras` opc LEFT JOIN orc_empenhos oe ON oe.orc_pedido_compra_id = opc.id WHERE oe.id IS NULL)
      @orc_pedido_compra = OrcPedidoCompra.find(session[:pedido_ids], :joins => "LEFT JOIN orc_empenhos ON orc_empenhos.orc_pedido_compra_id = orc_pedido_compras.id ")
      t=0
   end
def impressao_sem_empenho
    @orc_pedido_compra = OrcPedidoCompra.find(session[:pedido_ids], :joins => "LEFT JOIN orc_empenhos ON orc_empenhos.orc_pedido_compra_id = orc_pedido_compras.id ")
        render :layout => "impressao"

end

end
