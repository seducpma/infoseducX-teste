class SeducCandidatosController < ApplicationController
  # GET /seduc_candidatos
  # GET /seduc_candidatos.xml
   




def votacao
  @funcionarios = SeducFuncionario.find(:all, :conditions=>['unidade_id =?', current_user.unidade_id ],:order => 'nome ASC')
 render 'votacao'

  end


def sel_participa
    @dadosparticipa = Participante.find(params[:inscricao_participante_id])
    @inscricao = Inscricao.find_by_participante_id(params[:inscricao_participante_id], :conditions => ['status = 1 and encerrado = 0'])
    render :update do |page|
      page.replace_html "informacoes", :partial => 'exibe_participante'
      unless @inscricao.present?
        if @dadosparticipa.possuidadosobrigatorios?
          page.replace_html "final", :text => "<input id='inscricao_submit' type='submit' value='Confirmar' name='commit'>"
        else
          page.replace_html "final", :text => "<a href='/participantes/#{params[:inscricao_participante_id]}/addemail'>Favor atualizar dados</a>"
        end
      else
        page.replace_html "final", :text => "<a href='/inscricaos/#{@inscricao.id}'>Inscrição já efetuada - visualize</a>"
      end

    end
  end

def verificacao_funcionario
  @dadosfuncionario = SeducFuncionario.find(params[:seduc_funcionario_id])
    render :update do |page|
      page.replace_html "dados_funcionario", :partial => 'funcionario'
    end
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
