class UnidadesController < ApplicationController
  # GET /unidades
  # GET /unidades.xml

   before_filter :load_unidades
   before_filter :load_estagiarios
   before_filter :load_tipos
   before_filter :load_sem_estagiarios
   before_filter :load_regiaos

def sobre
  
end

def load_regiaos
    @regiaos = Regiao.find(:all, :order => 'regiao ASC')
  end
  
def load_sem_estagiarios
    @sem_estagiario =Unidade.find(:all, :order => 'nome ASC')
  end

def load_tipos
    @tipos =Tipo.find(:all, :order => 'nome ASC')
  end

def load_estagiarios
    @estagiarios = Estagiario.find(:all, :order => 'nome ASC')
  end

   def load_unidades
    @unidades = Unidade.find(:all, :order => 'nome ASC',:conditions => ['id != 71 and id !=72 and id !=73 and id !=76 and id !=77 and id !=75'] )
  end
  
  def index
    if (params[:search].nil? || params[:search].empty?)
      #@unidades = Unidade.find(:all, :order => 'nome ASC')
      @unidades = Unidade.paginate :page => params[:page], :order => 'nome ASC', :per_page => 15
      $var = 0
    else
      @unidades = Unidade.find(:all, :conditions => ["nome like ?", "%" + params[:search].to_s + "%"], :order => 'nome ASC')
      $var = 1
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @unidades }
    end
  end

  # GET /unidades/1
  # GET /unidades/1.xml
  def show
    @unidades = Unidade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @unidades }
    end
  end

  # GET /unidades/new
  # GET /unidades/new.xml
  def new
    @unidades = Unidade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @unidades }
    end
  end

  # GET /unidades/1/edit
  def edit
    @unidades = Unidade.find(params[:id])
  end

  # POST /unidades
  # POST /unidades.xml
  def create
    @unidades = Unidade.new(params[:unidade])
    respond_to do |format|
      if @unidades.save
        flash[:notice] = 'UNIDADE CADASTRADA COM SUCESSO.'
        format.html { redirect_to(@unidades) }
        format.xml  { render :xml => @unidades, :status => :created, :location => @unidades }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @unidades.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /unidades/1
  # PUT /unidades/1.xml
  def update
    @unidades = Unidade.find(params[:id])

    respond_to do |format|
      if @unidades.update_attributes(params[:unidade])
        flash[:notice] = 'UNIDADES SALVA COM SUCESSO.'
        format.html { redirect_to(@unidades) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @unidades.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /unidades/1
  # DELETE /unidades/1.xml
  def destroy
    @unidades = Unidade.find(params[:id])

    $uni_id = params[:id]
    @estagiario = Estagiario.find(:all, :conditions => ['unidade_id = ' + $uni_id])
    @laboratorio = Laboratorio.find(:all, :conditions => ['unidade_id = ' + $uni_id])
    @administracao = Administracao.find(:all, :conditions => ['unidade_id = ' + $uni_id])
    for estagiario in @estagiario
      estagiario.destroy
    end
    for laboratorio in @laboratorio
      laboratorio.destroy
    end
    for administracao in  @administracao
      administracao.destroy
    end
    @unidades.destroy

  respond_to do |format|
      format.html { redirect_to(homes_path) }
      format.xml  { head :ok }
    end
  end

def mesmo_nome
    $nome = params[:unidade_nome]
    @verifica = Unidade.find_by_nome($nome)
    if @verifica then
      render :update do |page|
        page.replace_html 'nome_aviso', :text => 'UNIDADE JÁ CADASTRADA NO SISTEMA'
        page.replace_html 'Certeza', :text =>'UNIDADE JÁ CADASTRADA NO SISTEMA'
    end
    else
      render :update do |page|
        page.replace_html 'nome_aviso', :text => ''
      end

    end
  end


def consulta
    render 'consultas'
  end

def lista_unidade
    $unidade = params[:unidade_unidade_id]
    @unidades = Unidade.find(:all, :conditions => ['id=' + $unidade])
    render :partial => 'lista_unidades'
  end

def consultatipo
    render 'consultastipo'
  end

def lista_tipo
    $tipo = params[:unidade_tipo_id]
    @tipos = Unidade.find(:all, :conditions => ['tipo_id=' + $tipo])
    render :partial => 'lista_tipos'
  end

def sem_estagiarios

     #@sem_estagiarios= Estagiario.find(:all, :joins => :unidade , :conditions => ["unidades.estagiarioV=0 or unidades.estagiarioM=0 or unidades.estagiarioN=0 or (unidades.id=53 or unidades.id=1 or unidades.id=3 or unidades.id=4 or unidades.id=5 or unidades.id=6 or unidades.id=7 or unidades.id=8 or unidades.id=9 or unidades.id=10) and (estagiarios.flag = 0 and desligado)= 0"], :order => 'unidades.nome ASC')

     @unidade_estagiario =Unidade.find(:all, :conditions => ["( unidades.id=1 or unidades.id=2 or unidades.id=3 or unidades.id=4 or unidades.id=5 or unidades.id=6 or unidades.id=7 or unidades.id=8 or unidades.id=9 or unidades.id=10 or unidades.id = 53)"], :order => 'unidades.nome ASC')
     @unidade_estagiario1 =Unidade.find(:all)
     



     #@sem_estagiarios= Unidade.find(:all, :conditions => ["estagiarioV=0 or estagiarioM=0 or (estagiarioN=0 and id!=53 and id!=1 and id!=3 and id!=4 and id!=5 and id!=6 and id!=7 and id!=8 and id!=9 and id!=10)"], :order => 'nome ASC')
     @sem_estagiarios_reg =  Regiao.all
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sem_estagiarios }
    end
  end

def print_all
   @unidades = Unidade.find(:all, :order => 'nome ASC')
   end

 def por_endereco
    if (params[:searche].nil? || params[:searche].empty?)
      @unidades = Unidade.paginate :page => params[:page], :order => 'nome ASC', :per_page => 15
      $var = 0
    else
      @unidades = Unidade.find(:all, :conditions => ["endereco like ?", "%" + params[:searche].to_s + "%"], :order => 'nome ASC')
      $var = 1
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @unidades }
    end
  end
end
