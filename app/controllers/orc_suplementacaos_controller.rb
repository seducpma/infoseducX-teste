class OrcSuplementacaosController < ApplicationController
  # GET /orc_suplementacaos
  # GET /orc_suplementacaos.xml

   before_filter :load_iniciais

 def load_iniciais
        @pedidos_compra = OrcPedidoCompra.all(:conditions =>['empenhado = 0'],:order => 'codigo ASC')
        @despesas = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
        @fichas = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')

        @orcamentarias= OrcUniOrcamentaria.find(:all, :conditions => ["ano = ?", Time.now.year])
          @orc_pedido_ano= OrcPedidoCompra.find(:all, :select => 'distinct(ano)')
       #@orc_ficha_descricao= OrcFicha.find(:all, :select => "distinct(descricao), CONCAT( ano , ' - ',descricao       ) AS descricao_ano", :order => ' descricao ASC , ano ASC' )
        #@orc_ficha_descricao= OrcFicha.find(:all, :select => 'distinct(descricao), id, CONCAT( descricao , ' - ',    ano   ) AS descricao_ano", :order => ' descricao ASC , ano ASC' )
 end


  def index
    @orc_suplementacaos = OrcSuplementacao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_suplementacaos }
    end
  end

  # GET /orc_suplementacaos/1
  # GET /orc_suplementacaos/1.xml
  def show
    @orc_suplementacao = OrcSuplementacao.find(params[:id])

    @orc_ficha_origem = OrcFicha.find(:all, :conditions => ["id = ?",@orc_suplementacao.orc_ficha_origem_id])
    @orc_ficha_origem1= OrcUniOrcamentaria.find(:all, :conditions => ["id=?",@orc_ficha_origem[0].orc_uni_orcamentaria_id ])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_suplementacao }
    end
  end

  # GET /orc_suplementacaos/new
  # GET /orc_suplementacaos/new.xml
  def new
    @orc_suplementacao = OrcSuplementacao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_suplementacao }
    end
  end

  # GET /orc_suplementacaos/1/edit
  def edit
    @orc_suplementacao = OrcSuplementacao.find(params[:id])
  end

  # POST /orc_suplementacaos
  # POST /orc_suplementacaos.xml
  def create
    @orc_suplementacao = OrcSuplementacao.new(params[:orc_suplementacao])

    respond_to do |format|
      if @orc_suplementacao.save
             # Atualiza saldo na ficha
        @ficha = OrcFicha.find(:all, :conditions => ['id =?', @orc_suplementacao.orc_ficha_id])
        @ficha_origem = OrcFicha.find(:all, :conditions => ['id =?', @orc_suplementacao.orc_ficha_origem_id])

        saldo_atual= @ficha[0].saldo_atual + @orc_suplementacao.valor_suplemento
        saldo= @ficha[0].saldo + @orc_suplementacao.valor_suplemento
        aporte= @ficha[0].saldo_aporte + @orc_suplementacao.valor_suplemento
        @ficha[0].saldo_atual = saldo_atual
        @ficha[0].saldo = saldo
        w1=@ficha[0].saldo_aporte = aporte.to_f
        saldo_atual_origem= @ficha_origem[0].saldo_atual - @orc_suplementacao.valor_suplemento
        saldo_origem= @ficha_origem[0].saldo - @orc_suplementacao.valor_suplemento
        transferido= @ficha_origem[0].saldo_transferido + @orc_suplementacao.valor_suplemento
        @ficha_origem[0].saldo_atual = saldo_atual_origem
        @ficha_origem[0].saldo = saldo_origem
        @ficha_origem[0].saldo_transferido = transferido.to_f

        @ficha[0].save
        @ficha_origem[0].save


        flash[:notice] = 'OrcSuplementacao was successfully created.'
        format.html { redirect_to(@orc_suplementacao) }
        format.xml  { render :xml => @orc_suplementacao, :status => :created, :location => @orc_suplementacao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_suplementacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_suplementacaos/1
  # PUT /orc_suplementacaos/1.xml
  def update
    @orc_suplementacao = OrcSuplementacao.find(params[:id])

    respond_to do |format|
      if @orc_suplementacao.update_attributes(params[:orc_suplementacao])
        flash[:notice] = 'OrcSuplementacao was successfully updated.'
        format.html { redirect_to(@orc_suplementacao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_suplementacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_suplementacaos/1
  # DELETE /orc_suplementacaos/1.xml
  def destroy
    @orc_suplementacao = OrcSuplementacao.find(params[:id])
    @orc_suplementacao.destroy


   # Atualiza saldo na ficha
         @ficha = OrcFicha.find(:all, :conditions => ['id =?', @orc_suplementacao.orc_ficha_id])
        @ficha_origem = OrcFicha.find(:all, :conditions => ['id =?', @orc_suplementacao.orc_ficha_origem_id])

        saldo_atual= @ficha[0].saldo_atual - @orc_suplementacao.valor_suplemento
        saldo= @ficha[0].saldo - @orc_suplementacao.valor_suplemento
        aporte= @ficha[0].saldo_aporte - @orc_suplementacao.valor_suplemento
        @ficha[0].saldo_atual = saldo_atual
        @ficha[0].saldo = saldo
        @ficha[0].saldo_aporte = aporte.to_f
        saldo_atual_origem= @ficha_origem[0].saldo_atual + @orc_suplementacao.valor_suplemento
        saldo_origem= @ficha_origem[0].saldo + @orc_suplementacao.valor_suplemento
        transferido= @ficha_origem[0].saldo_transferido - @orc_suplementacao.valor_suplemento
        @ficha_origem[0].saldo_atual = saldo_atual_origem
        @ficha_origem[0].saldo = saldo_origem
        @ficha_origem[0].saldo_transferido = transferido.to_f

        @ficha[0].save
        @ficha_origem[0].save

    respond_to do |format|
      format.html { redirect_to(home_path) }
      format.xml  { head :ok }
    end
  end

def dados_ficha
    @dados_ficha=  OrcFicha.find(:all, :conditions => ['id = ?',params[:orc_suplementacao_orc_ficha_id]])
     render :partial => "dados_fichas"
end

def dados_ficha_origem
    @dados_ficha=  OrcFicha.find(:all, :conditions => ['id = ?',params[:orc_suplementacao_orc_ficha_origem_id]])

     render :partial => "dados_fichas"
end



def ficha_suplementacao
     @suplementacaos = OrcSuplementacao.find(:all, :conditions => ['orc_ficha_id= ? ', params[:orc_suplementacao_orc_ficha_id]])
  render :partial => "suplementacaos"

end
def ficha_suplementacao_debito
     @suplementacaos = OrcSuplementacao.find(:all, :conditions => ['orc_ficha_origem_id= ? ', params[:orc_suplementacao_orc_ficha_origem_id]])
  render :partial => "suplementacaos_debito"

end

  def consulta_suplementacao
    if params[:type_of].to_i == 1   #fornecedor
         #@empenhos = OrcEmpenho.find(:all,:conditions => ['id != 1 and interessado like ?', "%" + params[:search_fornecedor].to_s + "%"], :order => 'id DESC')
         # render :update do |page|
         #         page.replace_html 'empenho', :partial => "empenhos"
         # end
    else if params[:type_of].to_i == 4   #todas
                 @suplementacaos = OrcSuplementacao.find(:all, :order => 'id DESC')
               render :update do |page|
                  page.replace_html 'suplementacao', :partial => "suplementacaos"
               end
         else if params[:type_of].to_i == 5   #dia
                    session[:dataI]=params[:suplementacao][:dataI][6,4]+'-'+params[:suplementacao][:dataI][3,2]+'-'+params[:suplementacao][:dataI][0,2]
                    session[:dataF]=params[:suplementacao][:dataF][6,4]+'-'+params[:suplementacao][:dataF][3,2]+'-'+params[:suplementacao][:dataF][0,2]
                    session[:mes]=params[:suplementacao][:dataF][3,2]
                     @suplementacaos = OrcSuplementacao.find_by_sql("SELECT * FROM orc_suplementacaos WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"') GROUP BY id ORDER BY data DESC")
                 render :update do |page|
                    page.replace_html 'suplementacao', :partial => "suplementacao"
                 end
              end
         end
     end
  end


end
