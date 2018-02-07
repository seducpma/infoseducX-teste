class CertificadosController < ApplicationController
  # GET /certificados
  # GET /certificados.xml
  #before_filter :login_required, :except => ["aviso", "index", "show", "create", "new","edit","sel_dados", "confirma", "confirma_agenda"]
  layout :define
   before_filter :load_iniciais


  def load_iniciais

            @cursos = Curso.find(:all, :order => 'nome ASC')

    end


  def index
    @certificados = Certificado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @certificados }
    end
  end

def aviso
  
end

  def define
    if logged_in?
      'application'
    else
      'inscricao'
    end
  end

  # GET /certificados/1
  # GET /certificados/1.xml
  def show
    @certificado = Certificado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @certificado }
    end
  end

  # GET /certificados/new
  # GET /certificados/new.xml
  def new
    @certificado = Certificado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @certificado }
    end
  end

  # GET /certificados/1/edit
  def edit
    @certificado = Certificado.find(params[:id])
  end

  # POST /certificados
  # POST /certificados.xml
  def create
    @certificado = Certificado.new(params[:certificado])
    @certificado.participante_id= params[:certificado][:participante_id]
    @inscricao = Inscricao.find(:all, :conditions =>['participante_id =? and curso_id =?', @certificado.participante_id, @certificado.curso_id ])
    w=@inscricao[0].id
    if  @inscricao[0].certificado == 1
          render  'ja_emitido'
    else
       respond_to do |format|
         @inscricao[0].certificado = 1
          @inscricao[0].save
          if @certificado.save
            flash[:notice] = 'CERTIFICADO SOLICITADO.'
            format.html { redirect_to(@certificado) }
            format.xml  { render :xml => @certificado, :status => :created, :location => @certificado }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @certificado.errors, :status => :unprocessable_entity }
          end
        end
    end
  end

  # PUT /certificados/1
  # PUT /certificados/1.xml
  def update
    @certificado = Certificado.find(params[:id])

    respond_to do |format|
      if @certificado.update_attributes(params[:certificado])
        flash[:notice] = 'Certificado was successfully updated.'
        format.html { redirect_to(@certificado) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @certificado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /certificados/1
  # DELETE /certificados/1.xml
  def destroy
    @certificado = Certificado.find(params[:id])
    @certificado.destroy

    respond_to do |format|
      format.html { redirect_to(certificados_url) }
      format.xml  { head :ok }
    end
  end

    def curso_participantes
        @participantes = Inscricao.find(:all, :select => "inscricaos.certificado, inscricaos.id, inscricaos.participante_id, inscricaos.curso_id, par.unidade_id,  par.funcao, uni.nome as uni_nome, par.nome as par_nome, cur.nome , par.id as par_id", :joins => "LEFT JOIN cursos cur ON cur.id = inscricaos.curso_id LEFT JOIN participantes par ON par.id = inscricaos.participante_id   LEFT JOIN "+session[:base]+".unidades uni ON uni.id = par.unidade_id  and inscricaos.participou = 1", :conditions => ['inscricaos.curso_id=? ', params[:certificado_curso_id]], :order => "par_nome ASC")
        render :partial => 'selecao_participante'
    end


end
