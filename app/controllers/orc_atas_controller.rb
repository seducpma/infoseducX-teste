class OrcAtasController < ApplicationController
  # GET /orc_atas
  # GET /orc_atas.xml


    before_filter :load_iniciais

 def load_iniciais
        #@pedidos_compra = OrcPedidoCompra.all(:order => 'codigo ASC')
          #@despesas = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
        @atas = OrcAta.find(:all, :conditions => ["DATE_ADD(data, INTERVAL 1 YEAR) > NOW()" ])
        @atas_saldo = OrcAta.find(:all, :select => 'id, concat( codigo, " - ", objetivo) as codigo_objetivo', :conditions => ["DATE_ADD(data, INTERVAL 1 YEAR) > NOW()" ])
        @fichas_emp = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')
        #@fichas = OrcEmpenho.find_by_sql("SELECT DISTINCT (fc.ficha) as ficha, emp.orc_pedido_compra_id, fc.id FROM orc_empenhos emp INNER JOIN orc_pedido_compras pc ON emp.orc_pedido_compra_id = pc.id INNER JOIN orc_fichas fc ON pc.orc_ficha_id = fc.id WHERE (fc.ano = "+(Time.now.year).to_s+" AND emp.id !=1 ) ORDER BY fc.ficha ASC")
        #@orcamentarias= OrcUniOrcamentaria.find(:all, :conditions => ["ano = ?", Time.now.year])
        #@orc_pedido_ano= OrcPedidoCompra.find(:all, :select => 'distinct(ano)')
 end






  def index
    @orc_atas = OrcAta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_atas }
    end
  end

  # GET /orc_atas/1
  # GET /orc_atas/1.xml
  def show
    @orc_ata = OrcAta.find(params[:id])
     @orc_ata_itens = OrcAtaIten.find(:all, :conditions => ['orc_ata_id=? ',@orc_ata.id ])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_ata }
    end
  end

  # GET /orc_atas/new
  # GET /orc_atas/new.xml
  def new
    @orc_ata = OrcAta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_ata }
    end
  end

  # GET /orc_atas/1/edit
  def edit
    @orc_ata = OrcAta.find(params[:id])
    @orc_ata_itens = OrcAtaIten.find(:all, :conditions => ['orc_ata_id=? ',@orc_ata.id ])
     session[:news_itens]= @orc_ata.id

  end

  # POST /orc_atas
  # POST /orc_atas.xml
  def create
    @orc_ata = OrcAta.new(params[:orc_ata])
    
    respond_to do |format|
      if @orc_ata.save
        session[:news_itens]= @orc_ata.id
        @ata = OrcAta.find(:all, :conditions =>['id=?',@orc_ata.id])

        flash[:notice] = 'OrcAta was successfully created.'
        format.html { redirect_to( {:action => "edit", :id =>@ata[0].id} ) }
        format.xml  { render :xml => @orc_ata, :status => :created, :location => @orc_ata }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_ata.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_atas/1
  # PUT /orc_atas/1.xml
  def update
    @orc_ata = OrcAta.find(params[:id])

    respond_to do |format|
      if @orc_ata.update_attributes(params[:orc_ata])
        flash[:notice] = 'OrcAta was successfully updated.'
        format.html { redirect_to(@orc_ata) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_ata.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_atas/1
  # DELETE /orc_atas/1.xml
  def destroy
    @orc_ata = OrcAta.find(params[:id])
    @orc_ata.destroy
    @ata =
    respond_to do |format|
      format.html { redirect_to( home_path ) }

      format.xml  { head :ok }
    end
  end


  def create_orc_ata_item
   #session[:create_new_itens]=1
   @orc_ata_item = OrcAtaIten.new(params[:orc_ata_item])
      valor_item= @orc_ata_item.total

      @orc_ata_item.orc_ata_id = session[:news_itens]
            # salva items da ata
      if @orc_ata_item.save
         @orc_ata_item.saldo=@orc_ata_item.quantidade


         @orc_ata_itens=OrcAtaIten.find(:all, :conditions =>['orc_ata_id =?', session[:news_itens]])

        for item in @orc_ata_itens

          w2=session[:soma]=session[:soma].to_f+item.total.to_f
          item.total_geral=session[:soma].to_f
          w1=session[:valor_total] = item.total_geral
          item_ata_id = item.orc_ata_id
          item.save
        end

         # salva valor_total no empenho
         @orc_ata= OrcAta.find(item_ata_id)
         @orc_ata.valor_total= session[:valor_total]
         @orc_ata.save
         @orc_ata_item.save



        render :update do |page|
          page.replace_html 'dados', :partial => "orc_ata_itens"
          page.replace_html 'new'
        end
       end
  end



 def destroy_itens
    @orc_ata_iten = OrcAtaIten.find(params[:id])
    session[:id_ata]= @orc_ata_iten.orc_ata_id
    valor_item = @orc_ata_iten.total
    @ata = OrcAta.find(:all, :conditions => ['id = ?', session[:id_ata]])
    @orc_ata_iten.destroy
    # salva valor_total no empenho
    @orc_ata_itens=OrcAtaIten.find(:all, :conditions =>['orc_ata_id =?', session[:id_ata] ])
    for item in @orc_ata_itens
          session[:soma]=session[:soma].to_f + item.total.to_f
          item.total_geral=session[:soma].to_f
          item.save
        end
     @ata[0].valor_total= session[:soma].to_f
     @ata[0].save
        respond_to do |format|
           flash[:notice] = 'ALTERADO COM SUCESSO.'
              format.html { redirect_to( {:action => "edit", :id => @ata[0].id} ) }
              format.html { redirect_to( @ata) }
              format.xml  { render :xml =>  @ata, :status => :created, :location =>  @ata }
          end
    end

def consulta_ata
    if params[:type_of].to_i == 1   #fornecedor
         @atas = OrcAta.find(:all,:conditions => ['interessado like ?', "%" + params[:search_fornecedor].to_s + "%"], :order => 'id DESC')
          render :update do |page|
                  page.replace_html 'ata', :partial => "atas"
          end
    else if params[:type_of].to_i == 2   # encerrando 30 dias

                  #@atas = OrcAta.find(:all, :conditions => ["DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()" ])
                   @atas = OrcAta.find(:all, :conditions => ["(DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()) AND (DATE_ADD(data, INTERVAL 1 YEAR) <= DATE_ADD(NOW(), INTERVAL 1 MONTH))" ], :order => 'data ASC')

               render :update do |page|
                  page.replace_html 'ata', :partial => "atas"
               end
         else if params[:type_of].to_i == 4   #todas
                 @atas = OrcAta.find(:all, :order => 'data ASC')
                   render :update do |page|
                      page.replace_html 'ata', :partial => "atas"
                   end
              else if params[:type_of].to_i == 5   #dia
                           session[:dataI]=params[:ata][:dataI][6,4]+'-'+params[:ata][:dataI][3,2]+'-'+params[:ata][:dataI][0,2]
                            session[:dataF]=params[:ata][:dataF][6,4]+'-'+params[:ata][:dataF][3,2]+'-'+params[:ata][:dataF][0,2]
                            session[:mes]=params[:ata][:dataF][3,2]
                             @atas = OrcAta.find_by_sql("SELECT * FROM orc_atas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data DESC")
                         render :update do |page|
                            page.replace_html 'ata', :partial => "atas"
                         end
                   else  if params[:type_of].to_i == 6   # encerrando 60 dias

                           #@atas = OrcAta.find(:all, :conditions => ["DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()" ])
                           @atas = OrcAta.find(:all, :conditions => ["(DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()) AND (DATE_ADD(data, INTERVAL 1 YEAR) <= DATE_ADD(NOW(), INTERVAL 2 MONTH))" ], :order => 'data ASC')

                               render :update do |page|
                                  page.replace_html 'ata', :partial => "atas"
                               end
                        end

                   end
              end
          end
     end
  end


def consulta_ata
    if params[:type_of].to_i == 1   #fornecedor
         @atas = OrcAta.find(:all,:conditions => ['interessado like ?', "%" + params[:search_fornecedor].to_s + "%"], :order => 'id DESC')
          render :update do |page|
                  page.replace_html 'ata', :partial => "atas"
          end
    else if params[:type_of].to_i == 2   # encerrando 30 dias

                  #@atas = OrcAta.find(:all, :conditions => ["DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()" ])
                   @atas = OrcAta.find(:all, :conditions => ["(DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()) AND (DATE_ADD(data, INTERVAL 1 YEAR) <= DATE_ADD(NOW(), INTERVAL 1 MONTH))" ], :order => 'data ASC')

               render :update do |page|
                  page.replace_html 'ata', :partial => "atas"
               end
         else if params[:type_of].to_i == 4   #todas
                 @atas = OrcAta.find(:all, :order => 'data ASC')
                   render :update do |page|
                      page.replace_html 'ata', :partial => "atas"
                   end
              else if params[:type_of].to_i == 5   #dia
                           session[:dataI]=params[:ata][:dataI][6,4]+'-'+params[:ata][:dataI][3,2]+'-'+params[:ata][:dataI][0,2]
                            session[:dataF]=params[:ata][:dataF][6,4]+'-'+params[:ata][:dataF][3,2]+'-'+params[:ata][:dataF][0,2]
                            session[:mes]=params[:ata][:dataF][3,2]
                             @atas = OrcAta.find_by_sql("SELECT * FROM orc_atas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data DESC")
                         render :update do |page|
                            page.replace_html 'ata', :partial => "atas"
                         end
                   else  if params[:type_of].to_i == 6   # encerrando 60 dias

                           #@atas = OrcAta.find(:all, :conditions => ["DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()" ])
                           @atas = OrcAta.find(:all, :conditions => ["(DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()) AND (DATE_ADD(data, INTERVAL 1 YEAR) <= DATE_ADD(NOW(), INTERVAL 2 MONTH))" ], :order => 'data ASC')

                               render :update do |page|
                                  page.replace_html 'ata', :partial => "atas"
                               end
                        end

                   end
              end
          end
     end
  end


def consulta_ata_produto

    if params[:type_of].to_i == 1   #fornecedor
         #@atas = OrcAta.find(:all,:conditions => ['interessado like ?', "%" + params[:search_fornecedor].to_s + "%"], :order => 'id DESC')
         @atas= OrcAta.find(:all, :joins=> 'LEFT JOIN orc_ata_itens ON orc_ata_itens.orc_ata_id = orc_atas.id ',  :select => 'orc_ata_itens.id AS item_id, orc_ata_itens.descricao AS produto, orc_ata_itens.quantidade AS quantidade, orc_ata_itens.saldo AS saldo,  orc_atas.interessado AS fornecedor,  orc_atas.codigo AS codigo_ata, orc_atas.modalidade AS modalidade, orc_atas.administrativo AS processo', :conditions => ['orc_atas.interessado like ?', "%" + params[:search_fornecedor_saldo].to_s + "%"], :order => 'orc_atas.codigo DESC, orc_ata_itens.descricao ASC' )
               render :update do |page|
                  page.replace_html 'ata', :partial => "ata_saldo"
               end
    else if params[:type_of].to_i == 2   
           @atas= OrcAta.find(:all, :joins=> 'LEFT JOIN orc_ata_itens ON orc_ata_itens.orc_ata_id = orc_atas.id ',  :select => 'orc_ata_itens.id AS item_id, orc_ata_itens.descricao AS produto, orc_ata_itens.quantidade AS quantidade, orc_ata_itens.saldo AS saldo,  orc_atas.interessado AS fornecedor,  orc_atas.codigo AS codigo_ata, orc_atas.modalidade AS modalidade, orc_atas.administrativo AS processo', :conditions => ['orc_ata_itens.saldo > 0'], :order => 'orc_atas.codigo DESC,orc_ata_itens.descricao ASC' )
               render :update do |page|
                  page.replace_html 'ata', :partial => "ata_saldo"
               end
         else if params[:type_of].to_i == 4   #produto
                 @atas= OrcAta.find(:all, :joins=> 'LEFT JOIN orc_ata_itens ON orc_ata_itens.orc_ata_id = orc_atas.id ',  :select => 'orc_ata_itens.id AS item_id, orc_ata_itens.descricao AS produto, orc_ata_itens.quantidade AS quantidade, orc_ata_itens.saldo AS saldo,  orc_atas.interessado AS fornecedor,  orc_atas.codigo AS codigo_ata, orc_atas.modalidade AS modalidade, orc_atas.administrativo AS processo', :conditions => ['orc_ata_itens.descricao like ?', "%" + params[:search_produto_saldo].to_s + "%"], :order => 'orc_atas.codigo DESC, orc_ata_itens.descricao ASC' )
                   render :update do |page|
                      page.replace_html 'ata', :partial => "ata_saldo"
                   end
              else if params[:type_of].to_i == 5   #dia NÂO FUNCIONA
                           #session[:dataI]=params[:ata][:dataI][6,4]+'-'+params[:ata][:dataI][3,2]+'-'+params[:ata][:dataI][0,2]
                           # session[:dataF]=params[:ata][:dataF][6,4]+'-'+params[:ata][:dataF][3,2]+'-'+params[:ata][:dataF][0,2]
                           # session[:mes]=params[:ata][:dataF][3,2]
                           #  @atas = OrcAta.find_by_sql("SELECT * FROM orc_atas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data DESC")
                         render :update do |page|
                            page.replace_html 'ata', :partial => "atas"
                         end
                   else  if params[:type_of].to_i == 6   # encerrando 60 dias NÂO FUNCIONA

                           #@atas = OrcAta.find(:all, :conditions => ["DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()" ])
                           #@atas = OrcAta.find(:all, :conditions => ["(DATE_ADD(data, INTERVAL 1 YEAR) >= NOW()) AND (DATE_ADD(data, INTERVAL 1 YEAR) <= DATE_ADD(NOW(), INTERVAL 2 MONTH))" ], :order => 'data ASC')

                               render :update do |page|
                                  page.replace_html 'ata', :partial => "atas"
                               end
                        end

                   end
              end
          end
     end
end



def ata_consulta
     @atas=  OrcAta.find(:all, :conditions => ['id = ?',params[:orc_ata_id]], :order => 'codigo DESC')
      render :partial => "atas"
end

def ata_consulta_saldo
     @atas= OrcAta.find(:all, :joins=> 'LEFT JOIN orc_ata_itens ON orc_ata_itens.orc_ata_id = orc_atas.id ',  :select => 'orc_ata_itens.id AS item_id, orc_ata_itens.descricao AS produto, orc_ata_itens.quantidade AS quantidade, orc_ata_itens.saldo AS saldo,  orc_atas.interessado AS fornecedor,  orc_atas.codigo AS codigo_ata, orc_atas.modalidade AS modalidade, orc_atas.administrativo AS processo',  :conditions => ['orc_atas.id = ?', params[:orc_ata_id] ], :order => 'orc_atas.codigo DESC, orc_ata_itens.descricao ASC' )
      render :partial => "ata_saldo"
end
end
