class SeducCandidatosController < ApplicationController
  # GET /seduc_candidatos
  # GET /seduc_candidatos.xml
 layout 'application'
 
  def votacao
  @funcionarios = SeducFuncionario.find(:all, :conditions=>['unidade_id =?', current_user.unidade_id ],:order => 'nome ASC')
 render 'votacao'

  end


 def sel_dados
    @dados = Sala.find(params[:reservar_sala_sala_id])
    session[:reservasala]= params[:reservar_sala_sala_id]
    #render :partial => 'exibe_dados'=>'dados_funcionario'
    render :update do |page|
      page.replace_html "especifica", :partial => 'exibe_dados'
    end
  end

def verificacao_funcionario
 @dadosfuncionario = SeducFuncionario.find(params[:seduc_funcionario_seduc_funcionario_id])
 session[:matriculabase]= @dadosfuncionario.matricula
   render :partial => 'funcionario'


end

def verificacao
 @fun = SeducFuncionario.all(:conditions => ["matricula = ?", params[:search]])
  render :update do |page|
       page.replace_html 'dados_funcionario', :partial => "habilitacao"
  end
  
  #if session[:matriculabase] = @funcionario.matricula
 #  render :partial => 'habilitado',  :text => 'HABILITADO'
 #else
 #  render :partial => 'naohabilitado', :text => 'NÂO HABILITADO'
 #end

end





  def index
    @seduc_candidatos = SeducCandidato.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seduc_candidatos }
    end
  end

  # GET /seduc_candidatos/1
  # GET /seduc_candidatos/1.xml
  def show
    @seduc_candidato = SeducCandidato.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seduc_candidato }
    end
  end

  # GET /seduc_candidatos/new
  # GET /seduc_candidatos/new.xml
  def new
    @seduc_candidato = SeducCandidato.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seduc_candidato }
    end
  end

  # GET /seduc_candidatos/1/edit
  def edit
    @seduc_candidato = SeducCandidato.find(params[:id])
  end

  # POST /seduc_candidatos
  # POST /seduc_candidatos.xml
  def create
    @seduc_candidato = SeducCandidato.new(params[:seduc_candidato])

    respond_to do |format|
      if @seduc_candidato.save
        flash[:notice] = 'SeducCandidato was successfully created.'
        format.html { redirect_to(@seduc_candidato) }
        format.xml  { render :xml => @seduc_candidato, :status => :created, :location => @seduc_candidato }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seduc_candidato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /seduc_candidatos/1
  # PUT /seduc_candidatos/1.xml
  def update
    @seduc_candidato = SeducCandidato.find(params[:id])

    respond_to do |format|
      if @seduc_candidato.update_attributes(params[:seduc_candidato])
        flash[:notice] = 'SeducCandidato was successfully updated.'
        format.html { redirect_to(@seduc_candidato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seduc_candidato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /seduc_candidatos/1
  # DELETE /seduc_candidatos/1.xml
  def destroy
    @seduc_candidato = SeducCandidato.find(params[:id])
    @seduc_candidato.destroy

    respond_to do |format|
      format.html { redirect_to(seduc_candidatos_url) }
      format.xml  { head :ok }
    end
  end






end
