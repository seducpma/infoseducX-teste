class SenhasController < ApplicationController

  before_filter :load_unidades

   def load_unidades
    @unidades = Unidade.find(:all, :order => 'nome ASC')
    
  end

  def index
     if (params[:search].nil? || params[:search].empty?)
      #@senhas = Senha.find(:all, :joins => "LEFT JOIN "+session[:base]+".unidades uni ON uni.id = senhas.unidade_id" , :order => 'nome ASC')
      @senhas = Senha.find_by_sql("SELECT uni.nome as nome, se.id, se.de, se.usuario, se.senha, se.fone, se.obs FROM senhas se INNER JOIN "+session[:base]+".unidades uni ON uni.id = se.unidade_id ")
      $var=0
    else
       #@senhas = Senha.find(:all, :joins => "LEFT JOIN "+session[:base]+".unidades uni ON uni.id = senhas.unidade_id", :conditions => ["uni.nome like ?", "%" + params[:search].to_s + "%"], :order => 'nome ASC')
      @senhas = Senha.find_by_sql("SELECT uni.nome as nome, se.id, se.de, se.usuario, se.senha, se.fone, se.obs FROM senhas se INNER JOIN "+session[:base]+".unidades uni ON uni.id = se.unidade_id  WHERE se.unidade_id = "+params[:search]+"  ")
       $var=1
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @senhas }
    end
  end

  def show
    @senhas = Senha.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @senhas }
    end
  end

  def new
    @senhas = Senha.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @senhas }
    end
  end

  def edit
    @senhas = Senha.find(params[:id])
  end

  def create
    @senhas = Senha.new(params[:senha])
    respond_to do |format|
      if @senhas.save
        flash[:notice] = 'SENHA CADASTRADA COM SUCESSO.'
        format.html { redirect_to(senhas_path) }
        format.xml  { render :xml => @senhas, :status => :created, :location => @senhas }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @senhas.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @senhas = Senha.find(params[:id])
    respond_to do |format|
      if @senhas.update_attributes(params[:senha])
        flash[:notice] = 'SENHA SALVA COM SUCESSO.'
        format.html { redirect_to(senhas_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @senhas.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @senhas = Senha.find(params[:id])
    @senhas.destroy
    respond_to do |format|
      format.html { redirect_to(home_path) }
      format.xml  { head :ok }
    end
  end

 def nome_unidade
   unidade = params[:senha_unidade_id]
   @senhaunidade = Unidade.find(:all, :include => 'estagiarios', :conditions => ['id =?',unidade])
   $nomeunidade= Unidade.find_by_id(unidade).nome
     render :update do |page|
       page.replace_html 'unidade_nome', :partial => 'exibe_unidade'
    end
  end
end
