class ManutencaosController < ApplicationController
  # GET /manutencaos
  # GET /manutencaos.xml
  before_filter :load_tipomanutencaos
  before_filter :load_unidades
  before_filter :load_funcionarios
  before_filter :load_situacaos
  before_filter :load_chefias


 def load_funcionarios
   if current_user.has_role?('administrador') or current_user.has_role?('admin_manutencao')
      @funcionarios = Funcionario.find(:all,:conditions => ['desligado=?',0], :order => 'nome ASC' )
   else
      @funcionarios = Funcionario.find(:all, :joins =>:chefia, :conditions => ['funcionarios.desligado=? and chefias.user_id =?',0, current_user], :order => 'nome ASC' )
   end
 end

  def load_chefias
    #if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao')
    #   @chefias = Chefia.find(:all, :conditions => ['desligado=?',0], :order => 'nome ASC')
    #  else
    #   @chefias = Chefia.find(:all, :joins => :manutencaos, :conditions => ['desligado=? and manutencaos.user_id=?',0,current_user ])
    #end
    @chefias1 = Chefia.find(:all,  :conditions => ['desligado=? ',0], :order => 'nome ASC')
    @chefias = Chefia.find(:all,  :conditions => ['desligado=? and user_id = ?',0, current_user], :order => 'nome ASC')
  end

  def load_situacaos
    @situacaos = SituacaoManutencao.find(:all)
  end


  def load_tipomanutencaos
       @tipos_manutencaos =  TiposManutencao.find(:all)
   end

   def load_unidades
       @unidades =  Unidade.find(:all, :order => 'nome ASC')
   end

def consulta

   render 'consultas'
  end

def lista_manutencao
    $chefia = params[:manutencao_chefia_id]
    @manutencaos   = Manutencao.find(:all, :conditions => ['chefia_id= ? and situacao_manutencao_id != 2', $chefia ])
    render :partial => 'lista_manutencao'
  end

  def index
    if current_user.has_role?('administrador') or current_user.has_role?('admin_manutencao')
       @manutencaos = Manutencao.all(:conditions =>  "situacao_manutencao_id <> 2")
    else
      if current_user.has_role?('diretor_unidade')
       @manutencaos = Manutencao.all(:conditions =>["situacao_manutencao_id <> 2 and unidade_id = ?",current_user.unidade_id ])
      else
       @manutencaos = Manutencao.all(:conditions =>["situacao_manutencao_id <> 2 and user_id = ?",current_user])
       $chefia1=@manutencaos.user_id.current_user
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @manutencaos }
    end
  end

  # GET /manutencaos/1
  # GET /manutencaos/1.xml
  def show
    @manutencao = Manutencao.find(params[:id])
    $idprotocolo = @manutencao.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @manutencao }
    end
  end

  # GET /manutencaos/new
  # GET /manutencaos/new.xml
  def new
    @manutencao = Manutencao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @manutencao }
    end
  end

  # GET /manutencaos/1/edit
  def edit
    @manutencao = Manutencao.find(params[:id])
  end

  # POST /manutencaos
  # POST /manutencaos.xml
  def create
    @manutencao = Manutencao.new(params[:manutencao])
    @manutencao.data_sol= Time.now
    @manutencao.user_id = current_user.id
    respond_to do |format|
      if @manutencao.save
        flash[:notice] = 'ORDEM DE SEVIÇO DE MANUTENÇÂO PROTOCOLADA.'
        format.html { redirect_to(@manutencao) }
        format.xml  { render :xml => @manutencao, :status => :created, :location => @manutencao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @manutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manutencaos/1
  # PUT /manutencaos/1.xml
  def update
    @manutencao = Manutencao.find(params[:id])
    @manutencao.data_sol= Time.now
    @manutencao.user_id = current_user.id
    respond_to do |format|
      if @manutencao.update_attributes(params[:manutencao])
        flash[:notice] = 'ORDEM SE SERVIÇO DE MANUTENÇÂO PROTOCOLADA.'
        format.html { redirect_to(@manutencao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @manutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manutencaos/1
  # DELETE /manutencaos/1.xml
  def destroy
    @manutencao = Manutencao.find(params[:id])
    @manutencao.destroy

    respond_to do |format|
      format.html { redirect_to(manutencaos_url) }
      format.xml  { head :ok }
    end
  end


  def despacho
    @manutencao = Manutencao.find(params[:id])
    @manutencao.data_ate = Time.now

  end

 def ordemservico
    @manutencao = Manutencao.find(params[:id])
    #@funcionarios = Funcionario.find(:all, :joins =>:chefia, :conditions => ['desligado=? and chefia.user_id',0, current_user], :order => 'nome ASC' )
 end

 def selected_print
   @manutencaos = Manutencao.find(params[:chamado_ids])
 end

 def impressao_manutencao
   @manutencao = Manutencao.find(params[:id])
   $idmanutencao= @manutencao.id

 end


 def protocolo
   t= $idprotocolo
    @manutencao= Manutencao.find(t)
   render :layout => "protocolo"
  end


 def imp_manutencao
   t= $idmanutencao
    @manutencao= Manutencao.find(t)
   render :layout => "protocolo"
  end


   def encerrados
    @manutencaos = Manutencao.find(:all, :conditions => ['situacao_manutencao_id =?',2], :order => 'data_enc DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @manutencaos }
    end
  end

 def showencerrado
     @manutencao = Manutencao.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @manutencao }
    end
 end

 def busca_protocolo
$ok=1
    if (params[:search].present?)
      if current_user.has_role?('administrador') or current_user.has_role?('admin_manutencao')
        @manutencao = Manutencao.find(:all, :conditions => ["id = ?",  params[:search]])
        $ok=0
     else
        if current_user.has_role?('diretor_unidade')
           @manutencao = Manutencao.find(:all, :conditions => ["id = ? and unidade_id=?",  params[:search], current_user.unidade_id])
           $ok=0
        else
           @manutencao = Manutencao.find(:all, :conditions => ["id = ?",  params[:search]])
           $ok=0
       end
     end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @manutencao }
    end
  end

end
