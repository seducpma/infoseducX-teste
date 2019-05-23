class ProdutosController < ApplicationController
  # GET /produtos
  # GET /produtos.xml
before_filter :load_iniciais


def  load_iniciais
      @produtos = Produto.all
end



  def index
    @produtos = Produto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @produtos }
    end
  end

  # GET /produtos/1
  # GET /produtos/1.xml
  def show
    @produto = Produto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @produto }
    end
  end

  # GET /produtos/new
  # GET /produtos/new.xml
  def new
    @produto = Produto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @produto }
    end
  end





  # GET /produtos/1/edit
  def edit
    @produto = Produto.find(params[:id])
  end

  # POST /produtos
  # POST /produtos.xml
  def create
    @produto = Produto.new(params[:produto])
    #@produto.estoque = @produto.estoque + @produto.entrada - @produto.saida

    respond_to do |format|
      if @produto.save
        flash[:notice] = 'Produto was successfully created.'
        format.html { redirect_to(@produto) }
        format.xml  { render :xml => @produto, :status => :created, :location => @produto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @produto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /produtos/1
  # PUT /produtos/1.xml
  def update
    @produto = Produto.find(params[:id])
    respond_to do |format|
      if @produto.update_attributes(params[:produto])
        flash[:notice] = 'PRODUTO CADASTRADO.'
        format.html { redirect_to(@produto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @produto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1
  # DELETE /produtos/1.xml
  def destroy
    @produto = Produto.find(params[:id])
    @produto.destroy

    respond_to do |format|
      format.html { redirect_to(produtos_url) }
      format.xml  { head :ok }
    end
  end


  def lista_produto

    @produtos = Produto.find(:all, :conditions => ['id =?', params[:produto_id]])
       render :update do |page|
          page.replace_html 'estoque', :partial => 'estoque'
         end
  end


  #def produto_entrada1
  #  @produto = Produto.find(params[:produto_id])
  #  session[:entrada]= 1
  #   render :action => "produto_entrada" , :layout => "layouts/lancamentos"
  #end

# def produto_saida2
 #   @produto = Produto.find(params[:produto_id])
 #   session[:saida]= 1
 #    render :action => "produto_saida" , :layout => "layouts/lancamentos"
 # end



#  def produto_entrada
#    @produto = Produto.find(params[:produto_id])
#    session[:entrada] = 1

#  end

#  def consulta_E
#    @produtos_cadastrados= Produto.all
#  end

#  def consulta_S
#    @produtos_cadastrados= Produto.all
#  end


end
