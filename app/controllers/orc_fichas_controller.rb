class OrcFichasController < ApplicationController
  # GET /orc_fichas
  # GET /orc_fichas.xml
   before_filter :load_iniciais

 def load_iniciais
        @orcamentaria = OrcUniOrcamentaria.all(:conditions => ["ano = ?", Time.now.year], :order => 'descricao ASC')
        @despesas = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
        @fichas = OrcFicha.all(:conditions => ["ano = ?", Time.now.year], :order => 'ficha ASC')
       @orc_ficha_ano= OrcFicha.find(:all, :select => 'distinct(ano)')
       @orc_ficha_descricao= OrcFicha.find(:all, :select => "distinct(descricao), CONCAT( ano , ' - ',descricao       ) AS descricao_ano", :order => ' descricao ASC , ano ASC' )
        #@orc_ficha_descricao= OrcFicha.find(:all, :select => 'distinct(descricao), id, CONCAT( descricao , ' - ',    ano   ) AS descricao_ano", :order => ' descricao ASC , ano ASC' )
 end

  def index

    @orc_fichas = OrcFicha.all(:conditions => ["ano = ?", Time.now.year])


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_fichas }
    end
  end

  # GET /orc_fichas/1
  # GET /orc_fichas/1.xml
  def show
    @orc_ficha = OrcFicha.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_ficha }
    end
  end

  # GET /orc_fichas/new
  # GET /orc_fichas/new.xml
  def new
    @orc_ficha = OrcFicha.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_ficha }
    end
  end

  # GET /orc_fichas/1/edit
  def edit
    @orc_ficha = OrcFicha.find(params[:id])
  end

  # POST /orc_fichas
  # POST /orc_fichas.xml
  def create
    @orc_ficha = OrcFicha.new(params[:orc_ficha])

    respond_to do |format|
      if @orc_ficha.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@orc_ficha) }
        format.xml  { render :xml => @orc_ficha, :status => :created, :location => @orc_ficha }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_ficha.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_fichas/1
  # PUT /orc_fichas/1.xml
  def update
    @orc_ficha = OrcFicha.find(params[:id])

    respond_to do |format|
      if @orc_ficha.update_attributes(params[:orc_ficha])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@orc_ficha) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_ficha.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_fichas/1
  # DELETE /orc_fichas/1.xml
  def destroy
    @orc_ficha = OrcFicha.find(params[:id])
    @orc_ficha.destroy

    respond_to do |format|
      format.html { redirect_to(orc_fichas_url) }
      format.xml  { head :ok }
    end
  end


def lista_orcamentaria
     @despesa= OrcUniDespesa.find(:all,:joins=> "INNER JOIN orc_uni_orcamentarias ON orc_uni_orcamentarias.orc_uni_despesa_id = orc_uni_despesas.id", :conditions =>['orc_uni_orcamentarias.id=? and orc_uni_orcamentarias.ano=?', params[:orc_ficha_orc_uni_orcamentaria_id], Time.now.year])

    render :partial => "orcamentaria"
  end


 def consulta_ficha
     if params[:type_of].to_i == 4   #todas
                   @orc_fichas = OrcFicha.find(:all, :order => 'ano ASC, ficha ASC')

               render :update do |page|
                  page.replace_html 'consultaficha', :partial => "fichas"
               end
    end
end

 def ficha_ano
   @orc_fichas = OrcFicha.find(:all, :conditions => ['ano = ?', params[:orc_ficha_ano]], :order => 'ano ASC, descricao ASC')
   render :partial => "fichas"
 end

 def ficha_descricao
   @orc_fichas = OrcFicha.find(:all, :conditions => ['descricao = ?', params[:orc_ficha_descricao]], :order => 'ano ASC, descricao ASC')
   render :partial => "fichas"
 end

  def ficha_numero
   @orc_fichas = OrcFicha.find(:all, :conditions => ['id = ?', params[:orc_ficha_id]], :order => 'ano ASC, descricao ASC')
   render :partial => "fichas"
 end

 def consulta_saldo
     if params[:type_of].to_i == 4   #todas
           @orc_fichas = OrcFicha.find(:all, :order => 'ano ASC, ficha ASC')
          render :update do |page|
               page.replace_html 'consultaficha', :partial => "saldos"
          end
    end
end

def ficha_saldo

   @orc_fichas = OrcFicha.find(:all, :conditions => ['id = ?', params[:orc_ficha_id]], :order => 'ano ASC, descricao ASC')

   render :partial => "saldos"
 end

def saldo_dotacao
    @un_despesa = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
end


def impressao_dotacao
     @un_despesa = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
     render :layout => "impressao"
end


end
