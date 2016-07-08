class InscricaosController < ApplicationController
  # GET /inscricaos
  # GET /inscricaos.xml
    before_filter :load_cursos
    before_filter :load_participantes
    before_filter :load_inscricaos
    before_filter :load_locais
    
  layout :define

  def envia_email
  end

  def modelo
    send_file("#{RAILS_ROOT}/public/documentos/modelo.doc" , :type=>"text/msword")
  end


  def confirmacao
    participante = Participante.find_by_matricula(params[:matricula])
    @inscricao = Inscricao.find_by_participante_id(participante_id)
    InscricaoMailer.deliver_confirmacao_inscricao(@inscricao,@inscricao.participante)

  end

  def kind
    t = 0
    y = 0
  end

  def define
    if logged_in?
      'application'
    else
      'inscricao'
    end
  end

  def index
    @inscricaos = Inscricao.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inscricaos }
    end

  end

  # GET /inscricaos/1
  # GET /inscricaos/1.xml
  def show
    @inscricao = Inscricao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inscricao }
    end
  end

  # GET /inscricaos/new
  # GET /inscricaos/new.xml
  def new
    @inscricao = Inscricao.find_by_participante_id(params[:participante])
    if @inscricao.present?
      @participante = Participante.find(@inscricao.participante_id)
      redirect_to(edit_inscricao_path(@inscricao))
    else
      @inscricao = Inscricao.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @inscricao }
      end
    end
  end

  # GET /inscricaos/1/edit
  def edit
    @inscricao = Inscricao.find(params[:id])
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
  # POST /inscricaos
  # POST /inscricaos.xml
  def create
    @inscricao = Inscricao.new(params[:inscricao])
    @inscricao.data_inscricao = Time.now
    respond_to do |format|

      if @inscricao.save
        @inscricao.valida_vaga
        flash[:notice] = 'INSCRIÇÃO CONFIRMADA COM SUCESSO.'
        InscricaoMailer.deliver_confirmacao_inscricao(@inscricao,@inscricao.participante)
        format.html { redirect_to(@inscricao) }
        format.xml  { render :xml => @inscricao, :status => :created, :location => @inscricao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inscricao.errors, :status => :unprocessable_entity }
      end

    end
  end

  # PUT /inscricaos/1
  # PUT /inscricaos/1.xml
  def update
    @inscricao = Inscricao.find(params[:id])


    respond_to do |format|
      if @inscricao.update_attributes(params[:inscricao])
        flash[:notice] = 'INSCRIÇÃO ATUALIZADA COM SUCESSO.'
        format.html { redirect_to(@inscricao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inscricao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inscricaos/1
  # DELETE /inscricaos/1.xml
  def destroy
    @inscricao = Inscricao.find(params[:id])
    @inscricao.destroy

    respond_to do |format|
      format.html { redirect_to(inscricaos_url) }
      format.xml  { head :ok }
    end
  end

 
 def listagem
   if params[:curso].present?
     @search = Curso.find(params[:curso][:get])
     @cursos_inscricaos = Inscricao.paginate(:all, {:page => params[:page],:per_page => 10, :include => 'cursos',:conditions => [ 'cursos.id =?', @search.id ]})
   end
 end
 
 def listagem_participantes
   if params[:curso].present?
     session[:opcao] = params[:periodo_opcao1]
     session[:unidade] = params[:curso][:unidade]
     session[:curso] = params[:curso][:get]

     
     c = session[:curso]
     o = session[:opcao]
     u = session[:unidade]
     @search = Curso.find(params[:curso][:get])
     unless session[:opcao].present?
       #@cursos_inscricaos = Inscricao.paginate(:all, {:page => params[:page],:per_page => 10, :include => 'cursos',:conditions => [ 'cursos.id =? ', @search.id]})
       @cursos_inscricaos=@contador = Inscricao.all(:include => 'cursos',:conditions => [ 'cursos.id =? ', @search.id])
     else
       #@cursos_inscricaos = Inscricao.paginate(:all, {:page => params[:page],:per_page => 10, :include => 'cursos',:conditions => [ 'cursos.id =? and (inscricaos.opcao1 = ? and inscricaos.periodo_opcao1 = ?)', @search.id,session[:unidade], session[:opcao] ]})
       i=@search.id
       u = session[:unidade]
       o = session[:opcao]
       @cursos_inscricaos=@contador = Inscricao.all(:include => 'cursos',:conditions => [ 'cursos.id =? and inscricaos.opcao1 = ? and inscricaos.periodoop1 = ?', @search.id,session[:unidade], session[:opcao] ])
       render :update do |page|
           page.replace_html 'lista', :partial => "inscritos_participantes" 
       end
       t=0
     end
     

   end
 end


def gera_pdf
   @search = Curso.find(params[:curso])
   unless session[:unidade].present?
     @contador = @cursos_inscricaos = Inscricao.all({:include => 'cursos',:conditions => [ 'cursos.id =? ', @search.id]})
     #@contador = Inscricao.all(:include => 'cursos',:conditions => [ 'cursos.id =? ', @search.id])
   else
     if session[:opcao] == "Todos"
       @cursos_inscricaos = Inscricao.all({:include => 'cursos',:conditions => [ 'cursos.id =? and (inscricaos.opcao1 = ? and inscricaos.periodo_opcao1 = ?)', @search.id,session[:unidade], session[:opcao] ], :order =>"inscricaos.id"})
     else
       @cursos_inscricaos = Inscricao.all({:include => 'cursos',:conditions => [ 'cursos.id =? and (inscricaos.opcao1 = ?)', @search.id,session[:unidade] ], :order =>"inscricaos.id"})
     end
     @contador = Inscricao.all(:include => 'cursos',:conditions => [ 'cursos.id =? ', @search.id])
   end
    respond_to do |format|
      format.html {render(:layout => false)} ## index.html.erb
      format.pdf do
        html = render_to_string(:layout => 'false' , :action => "gera_pdf.erb")
        kit = PDFKit.new(html)
        kit.stylesheets << "#{Rails.root}/public/stylesheets/pdf.css"
        send_data(kit.to_pdf, :filename => "#{@search.nome_curto}.pdf", :type => 'application/pdf')
      end
    end
 end


 def gera_excel(inscricao)
        ## Gera arquivo em pdf
     #@inscricao = Inscricao.all(:include => "cursos",:conditions => [ 'cursos.id =1' ])
     @report = DailyOrdersXlsFactory.new("simple report")
     @report.add_column(10).add_column(40).add_column(30).add_column(30).add_column(30)
     @report.add_row(["Prefeitura Municipal de Americana"], 30).join_last_row_heading(0..6)
     @report.add_row(["Inscritos no curso: #{@search.truncar_curso} "], 30).join_last_row_heading(0..6)
     @report.add_row(["Matricula","Nome","Unidade","Opção 1","Horario","Opçao 2","Horario"])
     inscricao.each do |insc|
       @report.add_row([insc.participante.matricula,insc.participante.nome,insc.participante.unidade.nome,insc.unidade(insc.opcao1),insc.periodo_opcao1,insc.unidade(insc.opcao2),insc.periodo_opcao2])
     end
     @rel = Relatorio.new
       @rel.ip = request.remote_ip
       @rel.user_id = current_user
       @rel.path = @report.save_to_file("public/saidas/#{@search.truncar_curso}_#{Date.today.strftime("%d_%m_%Y")}_#{@rel.user.login}.xls")
     @rel.save

 end

 def por_curso
   @search = Inscricao.search(params[:search])
   if (params[:search]).present?
    @curso = @search.paginate(:all,:page=>params[:page],:per_page =>20, :order => sort_column + " " + sort_direction)
   end
   render :action => 'por_curso'
 end


 def lista_inscricao
    $curso = params[:curso_curso_id]
    @inscricaos = Inscricao.find(:all, :conditions => ['curso_id=' + $curso ])
    render :partial => 'lista_inscricao'
 end

 def estatistica
    @cursos = Curso.find(:all,:conditions => ['cursos.status= 0'], :order => 'nome ASC')
    @cursosE = Curso.find(:all,:conditions => ['cursos.status= 1'], :order => 'nome ASC')
    @inscricaos = Inscricao.find(:all, :include => 'cursos', :conditions => ['cursos.status= 0'])
    @inscricaosE = Inscricao.find(:all, :include => 'cursos', :conditions => ['cursos.status= 1'])
  end


 def consultas
   @participantess =  Participante.find_by_id(params[:inscricao_inscricao_participante_id])

 end


 def consultas1
   @inscricaos = Inscricao.find(:all, :conditions => ['participante_id=?',  $idparticipante ],:order => "created_at DESC")
 end

 def lista_inscricaos
     $participante = params[:inscricao_inscricao_participante_id]
    @inscricaos = Inscricao.find(:all, :conditions => ['participante_id=?',  $participante ])
    render :partial => 'inscricaos'
 end

private

  def sort_column
    Inscricao.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end



protected


  def load_locais
    @locais = Unidade.find(:all, :order => 'nome ASC')
  end

  def load_inscricaos
    @inscricaos = Inscricao.find(:all)
  end

  def load_cursos
    @cursos = Curso.find(:all, :order => 'nome ASC', :conditions => ['status = 0 AND vagas_disponiveis > 0'])
  end


  def load_participantes
    if params[:participante].present?
      @participante = Participante.find(params[:participante], :order => 'nome ASC')
    else
      @participantes = Participante.find(:all, :conditions => ['flag = 1 and funcao is not null'], :order => 'nome ASC')
    end
  end


end
