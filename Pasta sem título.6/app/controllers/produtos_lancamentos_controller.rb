class ProdutosLancamentosController < ApplicationController
  # GET /produtos_lancamentos
  # GET /produtos_lancamentos.xml
  before_filter :load_iniciais

  def load_iniciais
   @produtos_cadastrados= Produto.all
  end

  def index_entrada
    @produtos_lancamentos = ProdutosLancamento.find(:all, :conditions => ['entrada != 0'])
  end

  def index_saida
    @produtos_lancamentos = ProdutosLancamento.find(:all, :conditions => ['saida != 0'])
  end

  def index_periodo
    @produtos_lancamentos = ProdutosLancamento.find(:all)
    
  end



  def show
    @produtos_lancamento = ProdutosLancamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @produtos_lancamento }
    end
  end


  def new_entrada
    @produtos_lancamento = ProdutosLancamento.new
    session[:entrada]= 1
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @produtos_lancamento }
    end
  end

  def new_saida
    @produtos_lancamento = ProdutosLancamento.new
    session[:saida]= 1
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @produtos_lancamento }
    end
  end

  # GET /produtos_lancamentos/1/edit
  def edit
    @produtos_lancamento = ProdutosLancamento.find(params[:id])
  end

  # POST /produtos_lancamentos
  # POST /produtos_lancamentos.xml
  def create
    @produtos_lancamento = ProdutosLancamento.new(params[:produtos_lancamento])
    @produtos= Produto.find(:all, :conditions => ['id =?', @produtos_lancamento.produto_id])

    respond_to do |format|
      if @produtos_lancamento.save
          if  session[:entrada] == 1
             @produtos_lancamento.data_entrada = Time.now
             @produtos_lancamento.funcionario_e= current_user.login
             @produtos[0].estoque = @produtos[0].estoque + @produtos_lancamento.entrada
             @produtos[0].save
             @produtos_lancamento.save
             session[:entrada]=0
          end
          if  session[:saida] == 1
             @produtos_lancamento.data_saida = Time.now
             @produtos_lancamento.funcionario_e= current_user.login
             @produtos[0].estoque = @produtos[0].estoque - @produtos_lancamento.saida
             @produtos[0].save
             @produtos_lancamento.save
             session[:saida]=0
          end

        flash[:notice] = 'LANÇAMENTO EFETUADO COM SUCESSO'
        format.html { redirect_to(@produtos_lancamento) }
        format.xml  { render :xml => @produtos_lancamento, :status => :created, :location => @produtos_lancamento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @produtos_lancamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /produtos_lancamentos/1
  # PUT /produtos_lancamentos/1.xml
  def update
    @produtos_lancamento = ProdutosLancamento.find(params[:id])

    respond_to do |format|
      if @produtos_lancamento.update_attributes(params[:produtos_lancamento])
        flash[:notice] = 'ProdutosLancamento was successfully updated.'
        format.html { redirect_to(@produtos_lancamento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @produtos_lancamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos_lancamentos/1
  # DELETE /produtos_lancamentos/1.xml
  def destroy
    @produtos_lancamento = ProdutosLancamento.find(params[:id])
    @produtos_lancamento.destroy

    respond_to do |format|
      format.html { redirect_to(produtos_lancamentos_url) }
      format.xml  { head :ok }
    end
  end


 def produto_lista
       @produto = Produto.find(:all, :conditions => ['id = ?', params[:produtos_lancamento_produto_id]])
       render :update do |page|
          page.replace_html 'produtos', :partial => 'produtos'
         end
 end


 def lista_produto_entrada_index
      session[:dataI]= params[:produtos_lancamento][:dataI][6,4]+'-'+ params[:produtos_lancamento][:dataI][3,2]+'-'+ params[:produtos_lancamento][:dataI][0,2]
      session[:dataF]=params[:produtos_lancamento][:dataF][6,4]+'-'+params[:produtos_lancamento][:dataF][3,2]+'-'+params[:produtos_lancamento][:dataF][0,2]
      session[:produtos_id]= params[:produtos_lancamento][:produto_id]
      @lancamentos_entradas = ProdutosLancamento.find(:all, :conditions =>  ["data_entrada between ? and ?  AND produto_id = ?  and entrada!=0", session[:dataI].to_s, session[:dataF].to_s, session[:produtos_id]], :order => 'data_entrada ASC')
      @produto= Produto.find(:all, :conditions => ['id =?', session[:produtos_id]])
       render :update do |page|
          page.replace_html 'lancamentos_entradas', :partial => 'lancamentos_entradas'
         end
 end


 def lista_produto_saida_index
      session[:dataI]= params[:produtos_lancamento][:dataI][6,4]+'-'+ params[:produtos_lancamento][:dataI][3,2]+'-'+ params[:produtos_lancamento][:dataI][0,2]
      session[:dataF]=params[:produtos_lancamento][:dataF][6,4]+'-'+params[:produtos_lancamento][:dataF][3,2]+'-'+params[:produtos_lancamento][:dataF][0,2]
      session[:produtos_id]= params[:produtos_lancamento][:produto_id]
      @lancamentos_entradas = ProdutosLancamento.find(:all, :conditions =>  ["data_saida between ? and ?  AND produto_id = ? and saida!=0 ", session[:dataI].to_s, session[:dataF].to_s, session[:produtos_id]], :order => 'data_saida ASC')
      @produto= Produto.find(:all, :conditions => ['id =?', session[:produtos_id]])
       render :update do |page|
          page.replace_html 'lancamentos_saidas', :partial => 'lancamentos_saidas'
         end
 end

 def lista_produto_periodo_index
      session[:dataI]= params[:produtos_lancamento][:dataI][6,4]+'-'+ params[:produtos_lancamento][:dataI][3,2]+'-'+ params[:produtos_lancamento][:dataI][0,2]
      session[:dataF]=params[:produtos_lancamento][:dataF][6,4]+'-'+params[:produtos_lancamento][:dataF][3,2]+'-'+params[:produtos_lancamento][:dataF][0,2]
      session[:produtos_id]= params[:produtos_lancamento][:produto_id]
      @lancamentos_periodo = ProdutosLancamento.find(:all, :conditions =>  ["((data_saida between ? and ?) or (data_entrada between ? and ?))AND produto_id = ? ", session[:dataI].to_s, session[:dataF].to_s,  session[:dataI].to_s, session[:dataF].to_s, session[:produtos_id]])
      @produto= Produto.find(:all, :conditions => ['id =?', session[:produtos_id]])
       render :update do |page|
          page.replace_html 'lancamentos_periodo', :partial => 'lancamentos_periodo'
         end
 end

end
