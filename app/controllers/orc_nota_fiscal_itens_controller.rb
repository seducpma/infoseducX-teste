class OrcNotaFiscalItensController < ApplicationController
  # GET /orc_nota_fiscal_itens
  # GET /orc_nota_fiscal_itens.xml
  def index
    @orc_nota_fiscal_itens = OrcNotaFiscalIten.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_nota_fiscal_itens }
    end
  end

  # GET /orc_nota_fiscal_itens/1
  # GET /orc_nota_fiscal_itens/1.xml
  def show
    @orc_nota_fiscal_iten = OrcNotaFiscalIten.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_nota_fiscal_iten }
    end
  end

  # GET /orc_nota_fiscal_itens/new
  # GET /orc_nota_fiscal_itens/new.xml
  def new
    @orc_nota_fiscal_iten = OrcNotaFiscalIten.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_nota_fiscal_iten }
    end
  end

  # GET /orc_nota_fiscal_itens/1/edit
  def edit
      t=0
    @orc_nota_fiscal_iten = OrcNotaFiscalIten.find(params[:id])
    @orc_nota_fiscal = OrcNotaFiscal.find(:all, :conditions=> ['id=?', @orc_nota_fiscal_iten.orc_nota_fiscal_id])

  end

  # POST /orc_nota_fiscal_itens
  # POST /orc_nota_fiscal_itens.xml
  def create
    @orc_nota_fiscal_iten = OrcNotaFiscalIten.new(params[:orc_nota_fiscal_iten])

    respond_to do |format|
      if @orc_nota_fiscal_iten.save
        flash[:notice] = 'SALVO COM SUCESSO..'
        format.html { redirect_to(@orc_nota_fiscal_iten) }
        format.xml  { render :xml => @orc_nota_fiscal_iten, :status => :created, :location => @orc_nota_fiscal_iten }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_nota_fiscal_iten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_nota_fiscal_itens/1
  # PUT /orc_nota_fiscal_itens/1.xml
  def update
    @orc_nota_fiscal_iten = OrcNotaFiscalIten.find(params[:id])
    @orc_nota_fiscal = OrcNotaFiscal.find(:all, :conditions=> ['id=?', @orc_nota_fiscal_iten.orc_nota_fiscal_id])
    if session[:edita_item]==1
        session[:quantidade] = @orc_nota_fiscal_iten.quantidade.to_f
        
    end
     
    respond_to do |format|
      if @orc_nota_fiscal_iten.update_attributes(params[:orc_nota_fiscal_iten])
         session[:altera_saldo_edicao_nfitem]=1

         #session[:edita_item]=1
         quantidade_iten = @orc_nota_fiscal_iten.quantidade.to_f
     
         @empenho = OrcEmpenho.find(:all, :joins => "INNER JOIN orc_nota_fiscals ON orc_empenhos.id = orc_nota_fiscals.orc_empenho_id INNER JOIN orc_nota_fiscal_itens ON orc_nota_fiscals.id = orc_nota_fiscal_itens.orc_nota_fiscal_id ", :conditions => ["orc_nota_fiscal_itens.id =?", @orc_nota_fiscal_iten.id])
         empenho = empenho_id= @empenho[0].id
         @empenho_iten= OrcEmpenhoIten.find(:all, :conditions => ['descricao=? and orc_empenho_id=?',@orc_nota_fiscal_iten.descricao , empenho])
         #empenho_id= @empenho_iten[0].id
         #saldo_atual= @empenho_iten[0].saldo.to_f
         #  @empenho_iten[0].saldo = quantidade.to_f - quantidade_iten.to_f
         @empenho_iten[0].save



        flash[:notice] = 'SALVO COM SUCESSO..'
        if session[:edita_item] == 0
              format.html { redirect_to( {:controller =>'orc_nota_fiscals' ,:action => "itens_na_nota_fiscal", :id => @orc_nota_fiscal[0].id} ) }
        else
              format.html { redirect_to( {:controller =>'orc_nota_fiscals' ,:action => "edit", :id => @orc_nota_fiscal[0].id} ) }
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_nota_fiscal_iten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_nota_fiscal_itens/1
  # DELETE /orc_nota_fiscal_itens/1.xml
  def destroy
    @orc_nota_fiscal_iten = OrcNotaFiscalIten.find(params[:id])
    @orc_nota_fiscal_iten.destroy

      
    respond_to do |format|
      format.html { redirect_to(orc_nota_fiscal_itens_url) }
      format.xml  { head :ok }
    end
  end
end
