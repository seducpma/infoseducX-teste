class OrcReservasController < ApplicationController
  # GET /orc_reservas
  # GET /orc_reservas.xml

     before_filter :load_iniciais

 def load_iniciais
        @canceladas = OrcReserva.find(:all,:select => "id, valor, CONCAT(justificativa, ' - R$ ', convert(valor,char) ) AS valor_justificativa",:conditions => ['cancela = ?', 1],:order => 'data ASC')
        @realizadas= OrcReserva.find(:all,:select => "id, valor, CONCAT(motivo, ' - R$ ', convert(valor,char)) AS valor_motivo",:conditions => ['cancela is null', 1],:order => 'data ASC')
        #@despesas = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
        @fichas = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')
        #@fichas = OrcEmpenho.find_by_sql("SELECT DISTINCT (fc.ficha) as ficha, emp.orc_pedido_compra_id, fc.id FROM orc_empenhos emp INNER JOIN orc_pedido_compras pc ON emp.orc_pedido_compra_id = pc.id INNER JOIN orc_fichas fc ON pc.orc_ficha_id = fc.id WHERE (fc.ano = "+(Time.now.year).to_s+" AND emp.id !=1 ) ORDER BY fc.ficha ASC")
        #@atas = OrcAta.find(:all, :conditions => ["DATE_ADD(data, INTERVAL 1 YEAR) > NOW()" ])
        #@orcamentarias= OrcUniOrcamentaria.find(:all, :conditions => ["ano = ?", Time.now.year])
        #@orc_pedido_ano= OrcPedidoCompra.find(:all, :select => 'distinct(ano)')
 end



  def index
    @orc_reservas = OrcReserva.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_reservas }
    end
  end

  # GET /orc_reservas/1
  # GET /orc_reservas/1.xml
  def show
    @orc_reserva = OrcReserva.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_reserva }
    end
  end

  # GET /orc_reservas/new
  # GET /orc_reservas/new.xml
  def new
    @orc_reserva = OrcReserva.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_reserva }
    end
  end

  # GET /orc_reservas/1/edit
  def edit
    @orc_reserva = OrcReserva.find(params[:id])
  end

  # POST /orc_reservas
  # POST /orc_reservas.xml
  def create
    @orc_reserva = OrcReserva.new(params[:orc_reserva])
       @ficha1=  OrcFicha.find(:all, :conditions => ['id = ?',session[:ficha_id]])
    respond_to do |format|
      if @orc_reserva.save
        @ficha=  OrcFicha.find(:all, :conditions => ['id = ?',@orc_reserva.orc_ficha_id])
        saldo_reservado = @ficha[0].saldo_reservado
        saldo_reservado = saldo_reservado + @orc_reserva.valor
        @ficha[0].saldo_reservado = saldo_reservado

       saldo  = @ficha[0].saldo
       saldo = saldo - @orc_reserva.valor
       @ficha[0].saldo = saldo
       @ficha[0].save
       @orc_reserva.save

        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@orc_reserva) }
        format.xml  { render :xml => @orc_reserva, :status => :created, :location => @orc_reserva }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_reserva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_reservas/1
  # PUT /orc_reservas/1.xml
  def update
    @orc_reserva = OrcReserva.find(params[:id])
         if params[:cancela].to_i == 1
               @orc_reserva.cancela=1

                @ficha = OrcFicha.find(:all, :conditions=>['id =?', @orc_reserva.orc_ficha_id])
                if !@ficha.empty?
                    saldo_reservado = @ficha[0].saldo_reservado
                    saldo_reservado = saldo_reservado - @orc_reserva.valor
                    @ficha[0].saldo_reservado = saldo_reservado

                   saldo  = @ficha[0].saldo
                   saldo = saldo + @orc_reserva.valor
                   @ficha[0].saldo = saldo
                   @ficha[0].save
                 end
                  @orc_reserva.save
              end

    respond_to do |format|
      if @orc_reserva.update_attributes(params[:orc_reserva])
        flash[:notice] = 'OrcReserva was successfully updated.'
        format.html { redirect_to(@orc_reserva) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_reserva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_reservas/1
  # DELETE /orc_reservas/1.xml
  def destroy
    @orc_reserva = OrcReserva.find(params[:id])
    @orc_reserva.destroy

    respond_to do |format|
      format.html { redirect_to(orc_reservas_url) }
      format.xml  { head :ok }
    end
  end

 def dados_ficha
       session[:ficha_id]=params[:orc_reserva_orc_ficha_id]
       @dados_ficha=  OrcFicha.find(:all, :conditions => ['id = ?',params[:orc_reserva_orc_ficha_id]])
       render :partial => "dados_fichas"
end


   def consulta_reserva
    if params[:type_of].to_i == 1   #ficha
         @reservas = OrcReserva.find(:all,:conditions => ['orc_ficha_id = ?', params[:orc_ficha_id] ], :order => 'data DESC')
          render :update do |page|
                  page.replace_html 'reserva', :partial => "reservas"
          end
    else if params[:type_of].to_i == 2   #cancelado    NÃO FUNCIONA
                 
               render :update do |page|
                  page.replace_html 'reserva', :partial => "reservas"
               end
         else if params[:type_of].to_i == 3   #realizado NÃO FUNCIONA

                 @empenhos = OrcEmpenho.find(:all, :joins=>['LEFT JOIN orc_pedido_compras ON orc_empenhos.orc_pedido_compra_id = orc_pedido_compras.id'], :conditions => ['orc_pedido_compras.codigo like ?', "%" + params[:search_si].to_s + "%"], :order => 'id DESC')

               render :update do |page|
                  page.replace_html 'reserva', :partial => "reservas"
               end
                 else if params[:type_of].to_i == 4   #data
                            w=session[:dataI]=params[:reserva][:dataI][6,4]+'-'+params[:reserva][:dataI][3,2]+'-'+params[:reserva][:dataI][0,2]
                            w1=session[:dataF]=params[:reserva][:dataF][6,4]+'-'+params[:reserva][:dataF][3,2]+'-'+params[:reserva][:dataF][0,2]
                            e2=session[:mes]=params[:reserva][:dataF][3,2]
                             @reservas = OrcReserva.find_by_sql("SELECT * FROM orc_reservas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data DESC")
                         render :update do |page|
                            page.replace_html 'reserva', :partial => "reservas"
                         end
                      else if params[:type_of].to_i == 5   #todos
                             @reservas = OrcReserva.find(:all, :order => 'data DESC')
                               render :update do |page|
                                 page.replace_html 'reserva', :partial => "reservas"
                                end
                            end
                      end
                 end
          end
     end
  end

 def cancelamento
       @reservas = OrcReserva.find(:all,:conditions => ['id = ? ', params[:orc_reserva_id]], :order => 'data DESC')
       render :partial => "reservas"
end

 def realizada
    @reservas = OrcReserva.find(:all, :conditions => ['id = ?', params[:orc_reserva_id]], :order => 'data DESC, motivo ASC')
    render :partial => "reservas"
 end

 def ficha_numero
     w=params[:orc_ficha_id]
     t=0
    @reservas = OrcReserva.find(:all, :conditions => ['orc_ficha_id = ?', params[:orc_ficha_id]], :order => 'data DESC, motivo ASC')
    render :partial => "reservas"
 end


end
