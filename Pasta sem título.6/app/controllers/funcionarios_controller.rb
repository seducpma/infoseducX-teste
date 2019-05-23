
class FuncionariosController < ApplicationController
     before_filter :load_iniciais

  def index
    @funcionarios = Funcionario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @funcionarios }
    end
  end

  def show
    @funcionario = Funcionario.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @funcionario }
    end
  end

  def new
    @funcionario = Funcionario.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @funcionario }
    end
  end

  def edit
    @funcionario = Funcionario.find(params[:id])
  end

  def create
    @funcionario = Funcionario.new(params[:funcionario])
    respond_to do |format|
      if @funcionario.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@funcionario) }
        format.xml  { render :xml => @funcionario, :status => :created, :location => @funcionario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @funcionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @funcionario = Funcionario.find(params[:id])
    respond_to do |format|
      if @funcionario.update_attributes(params[:funcionario])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@funcionario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @funcionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @funcionario = Funcionario.find(params[:id])
    @funcionario.destroy
    respond_to do |format|
      format.html { redirect_to(funcionarios_url) }
      format.xml  { head :ok }
    end
  end

 def lista_consulta_funcionario
      @funcionarios = Funcionario.find(:all, :conditions => ['desligado =0 and id= ?', params[:funcionario_id]])
    render :partial => 'funcionarios'
 end

 def lista_consulta_periodo_est
 end

 def lista_consulta_funcao
      if current_user.unidade_id == 52 or current_user.unidade_id == 53
         @funcionarios = Funcionario.find(:all, :conditions => ['desligado =0 and funcao = ? ',  params[:funcionario_funcao]])
      else
         @funcionarios = Funcionario.find(:all, :conditions => ['desligado =0 and funcao = ? and unidade_id =?',  params[:funcionario_funcao], current_user.unidade_id])
      end
    render :partial => 'funcionarios'
 end

 def lista_consulta_unidade
      @funcionarios = Funcionario.find(:all, :conditions => ['desligado =0 and unidade_id= ?',  params[:funcionario_unidade_id]])
    render :partial => 'funcionarios'
 end

def consulta_funcionario
    if params[:type_of].to_i == 5
            @funcionarios = Funcionario.find(:all, :conditions => ['desligado =1 '])
           render :update do |page|
                page.replace_html 'dados', :partial => "funcionarios"
              end
         else if params[:type_of].to_i == 6
            @funcionarios = Funcionario.find(:all, :conditions => ['desligado =0 '])
           render :update do |page|
                page.replace_html 'dados', :partial => "funcionarios"
              end

              end
    end
  end

  def load_iniciais
      if current_user.unidade_id == 52 or current_user.unidade_id == 53
          @unidades = Unidade.find(:all, :order => 'nome ASC')
      else
         @unidades = Unidade.find(:all, :conditions =>['id =?' , current_user.unidade_id], :order => 'nome ASC')
      end
     @funcao = Funcionario.find(:all,  :select => 'distinct(funcao)',:order => 'funcao ASC')
  end

end
