class OrcEmpenhoItensController < ApplicationController
  # GET /orc_empenho_itens
  # GET /orc_empenho_itens.xml
  def index
    @orc_empenho_itens = OrcEmpenhoIten.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_empenho_itens }
    end
  end

  # GET /orc_empenho_itens/1
  # GET /orc_empenho_itens/1.xml
  def show
    @orc_empenho_iten = OrcEmpenhoIten.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_empenho_iten }
    end
  end

  # GET /orc_empenho_itens/new
  # GET /orc_empenho_itens/new.xml
  def new
    @orc_empenho_iten = OrcEmpenhoIten.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_empenho_iten }
    end
  end

  # GET /orc_empenho_itens/1/edit
  def edit
      @orc_empenho_iten = OrcEmpenhoIten.find(params[:id])
      @orc_empenho =OrcEmpenho.find(:all, :conditions=>['id=?',@orc_empenho_iten.orc_empenho_id ])
       session[:volta]=1
      

  end


 def saldo
      session[:volta]=1
      @orc_empenho_iten = OrcEmpenhoIten.find(params[:id])
      @orc_empenho =OrcEmpenho.find(:all, :conditions=>['id=?',@orc_empenho_iten.orc_empenho_id ])
      id=(params[:id]).to_s
      @produto= OrcEmpenho.find(:all, :joins=> 'LEFT JOIN orc_empenho_itens ON orc_empenho_itens.orc_empenho_id = orc_empenhos.id LEFT JOIN orc_nota_fiscals ON orc_nota_fiscals.orc_empenho_id = orc_empenhos.id LEFT JOIN orc_nota_fiscal_itens ON orc_nota_fiscals.id = orc_nota_fiscal_itens.orc_nota_fiscal_id',  :select => 'orc_empenho_itens.id AS item_id, orc_empenho_itens.descricao AS produto, orc_empenho_itens.quantidade AS quantidade, orc_empenhos.interessado AS fornecedor,  orc_empenhos.codigo AS nempenho, orc_empenho_itens.saldo AS saldo,   (date_format(orc_empenhos.data,"%d/%m/%Y")) AS datae , (date_format(orc_empenhos.data_chegou,"%d/%m/%Y")) AS datac, orc_empenhos.cancelado AS cancelado, orc_nota_fiscals.nf AS nnf , orc_nota_fiscal_itens.quantidade as quantidade_nf',  :conditions => ['orc_empenho_itens.id = ? and orc_nota_fiscal_itens.descricao = orc_empenho_itens.descricao' , params[:id] ], :order => 'orc_nota_fiscals.nf DESC, orc_nota_fiscal_itens.id ASC' )
      session[:volta]=0



  end
  # POST /orc_empenho_itens
  # POST /orc_empenho_itens.xml
  def create
    @orc_empenho_iten = OrcEmpenhoIten.new(params[:orc_empenho_iten])

    respond_to do |format|
      if @orc_empenho_iten.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@orc_empenho_iten) }
        format.xml  { render :xml => @orc_empenho_iten, :status => :created, :location => @orc_empenho_iten }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_empenho_iten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_empenho_itens/1
  # PUT /orc_empenho_itens/1.xml
  def update
    @orc_empenho_iten = OrcEmpenhoIten.find(params[:id])
    @orc_empenho = OrcEmpenho.find(:all, :conditions=> ['id=?', @orc_empenho_iten.orc_empenho_id])
    respond_to do |format|
      if @orc_empenho_iten.update_attributes(params[:orc_empenho_iten])
        flash[:notice] = 'SALVO COM SUCESSO'
        if session[:volta]== 1
            format.html { redirect_to( {:controller =>'orc_empenhos' ,:action => "edit", :id => @orc_empenho[0].id} ) }
            format.html { redirect_to( {:controller =>'orc_pedido_compras' ,:action => "edit", :id => @orc_pedido_compra[0].id} ) }
            
            session[:volta] =0
        else
             format.html { redirect_to(consulta_produto_orc_empenhos_path ) }
             format.xml  { head :ok }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_empenho_iten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_empenho_itens/1
  # DELETE /orc_empenho_itens/1.xml
  def destroy
    @orc_empenho_iten = OrcEmpenhoIten.find(params[:id])
    @orc_empenho_iten.destroy

    respond_to do |format|
      format.html { redirect_to(orc_empenho_itens_url) }
      format.xml  { head :ok }
    end
  end
end
