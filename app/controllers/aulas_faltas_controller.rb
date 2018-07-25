class AulasFaltasController < ApplicationController

    before_filter :load_iniciais

    def index
        @date = params[:month] ? Date.parse(params[:month]) : Date.today
        @date.strftime("%m")
        @search = AulasFalta.search(params[:search])
        if !(params[:search].blank?)
            @aulas_faltas = @search.all
            @aulas_faltas_unidade = @search.first
        end
        session[:search]=params[:search]
        if !(params[:search].blank?)
            params[:search][:unidade_id_equals]
            @faltas_professor = AulasFalta.find_by_sql("SELECT professor_id, count( id ) as conta FROM aulas_faltas WHERE (month( data) = "+@date.strftime("%m")+" AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(params[:search][:unidade_id_equals]).to_s+" AND professor_id IS NOT NULL ) GROUP BY professor_id")
            @faltas_funcionario = AulasFalta.find_by_sql("SELECT funcionario_id, count( id ) as conta FROM aulas_faltas WHERE (month( data) = "+@date.strftime("%m")+" AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(params[:search][:unidade_id_equals]).to_s+" AND funcionario_id IS NOT NULL) GROUP BY professor_id")
        end
        session[:funcionario] = 1
        session[:professor] = 1
    end

    def index2
        if current_user.unidade.tipo_id == 2   or current_user.unidade.tipo_id == 5 or  current_user.unidade.tipo_id == 8
            session[:infantil]= 0
        else
            session[:infantil]= 1
         end
        session[:unidade]= current_user.unidade_id
        @date = params[:month] ? Date.parse(params[:month]) : Date.today
        @search = AulasFalta.search(params[:search])
        if !(params[:search].blank?)
            @aulas_faltas = @search.all
            @aulas_faltas_unidade = @search.first
        end
        session[:professor] =1
        session[:funcionario] =0
    end

    def index3
        if current_user.unidade.tipo_id == 2   or current_user.unidade.tipo_id == 5 or  current_user.unidade.tipo_id == 8
            session[:infantil]= 0
        else
            session[:infantil]= 1
         end
        @date = params[:month] ? Date.parse(params[:month]) : Date.today
        @search = AulasFalta.search(params[:search])
        if !(params[:search].blank?)
            @aulas_faltas = @search.all
            @aulas_faltas_unidade = @search.first
        end
        session[:funcionario] =1
        session[:professor] =0
    end

    def show
        @aulas_falta = AulasFalta.find(params[:id])
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @aulas_falta }
        end
    end

    def new
        @aulas_falta = AulasFalta.new
        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @aulas_falta }
        end
    end

    def edit
        @aulas_falta = AulasFalta.find(params[:id])
    end

    def create
        @aulas_falta = AulasFalta.new(params[:aulas_falta])
        @aulas_falta.ano_letivo =  Time.now.year
        @aulas_falta.funcao = session[:funcao]
        @aulas_falta.setor = session[:setor]
        @aulas_falta.classe = session[:profclasse]
        @aulas_falta.periodo = session[:classeper]
        respond_to do |format|
            if @aulas_falta.save
                flash[:notice] = 'SALVO COM SUCESSO.'
                format.html { redirect_to(@aulas_falta) }
                format.xml  { render :xml => @aulas_falta, :status => :created, :location => @aulas_falta }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @aulas_falta.errors, :status => :unprocessable_entity }
            end
        end
    end

    def update
        @aulas_falta = AulasFalta.find(params[:id])
        respond_to do |format|
            if @aulas_falta.update_attributes(params[:aulas_falta])
                flash[:notice] = 'SALVO COM SUCESSO.'
                format.html { redirect_to(@aulas_falta) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @aulas_falta.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        @aulas_falta = AulasFalta.find(params[:id])
        @aulas_falta.destroy
        respond_to do |format|
            format.html { redirect_to(aulas_faltas_url) }
            format.xml  { head :ok }
        end
    end

    def data_falta
     session[:aulas_falta_data]=params[:aulas_falta_data][6,4]+'-'+params[:aulas_falta_data][3,2]+'-'+params[:aulas_falta_data][0,2]

    end


    def nome_falta

        session[:aulas_falta_unidade_id]=params[:aulas_falta_unidade_id]
        @tipo_unidade = Unidade.find(:all, :select => ['id, tipo_id'] , :conditions => ['id =?',  current_user.unidade_id]  )
        if @tipo_unidade[0].tipo_id == 8 or @tipo_unidade[0].tipo_id == 5 or @tipo_unidade[0].tipo_id == 2
           @professores = Professor.find(:all, :conditions => ['unidade_id =? ', params[:aulas_falta_unidade_id]], :order => 'nome ASC')
           @funcionarios = Funcionario.find(:all, :conditions => ['unidade_id =? ', params[:aulas_falta_unidade_id]], :order => 'nome ASC')

        else
           @professores = Professor.find(:all, :conditions => ['unidade_id =? or unidade_id = 53 or  unidade_id = 75 or diversas_unidades = 1 and (funcao !="PROF. DE CRECHE" and funcao != "ADI" and funcao !="PEB1 - ED. INFANTIL"  )    ', params[:aulas_falta_unidade_id]], :order => 'nome ASC')
           @funcionarios = Funcionario.find(:all, :conditions => ['unidade_id =? ', params[:aulas_falta_unidade_id]], :order => 'nome ASC')

        end

        if (@professores.present?) or (@funcionarios.present?)

            render :partial => 'selecao_falta'

        else
            render :partial => 'aviso'
        end
    end


    def relatorios_faltas
        session[:tiporelatorio]=1
        session[:verifica_unidade_id]=params[:aulas_falta][:unidade_id]
        session[:dia_final]=params[:diaF]
        session[:mesF]=params[:mesF]
        session[:dataI]=params[:aulas_falta][:dataI][6,4]+'-'+params[:aulas_falta][:dataI][3,2]+'-'+params[:aulas_falta][:dataI][0,2]
        session[:dataF]=params[:aulas_falta][:dataF][6,4]+'-'+params[:aulas_falta][:dataF][3,2]+'-'+params[:aulas_falta][:dataF][0,2]
        session[:mes]=params[:aulas_falta][:dataF][3,2]
        if session[:mes] == '01'
            session[:mes] = 'JANEIRO'
        else if session[:mes] == '02'
                session[:mes] = 'FEVEREIRO'
            else if session[:mes] == '03'
                    session[:mes] = 'MARÇO'
                else if session[:mes] == '04'
                        session[:mes] = 'ABRIL'
                    else if params[:mes] == '05'
                            session[:mes] = 'MAIO'
                        else if session[:mes] == '06'
                                session[:mes] = 'JUNHO'
                            else if session[:mes] == '07'
                                    session[:mes] = 'JULHO'
                                else if session[:mes] == '08'
                                        session[:mes] = 'AGOSTO'
                                    else if session[:mes] == '09'
                                            session[:mes] = 'SETEMBRO'
                                        else if session[:mes] == '10'
                                                session[:mes] = 'OUTUBRO'
                                            else if session[:mes] == '11'
                                                    session[:mes] = 'NOVEMBRO'
                                                else if session[:mes] == '12'
                                                        session[:mes] = 'DEZEMBRO'
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        session[:mostra_faltas_funcionario] = 1
        session[:mostra_faltas_professor] = 1
        session[:aulas_falta_unidade_id] = params[:aulas_falta][:unidade_id]
        if (session[:verifica_unidade_id]=='52')
            @aulas_faltas = AulasFalta.find(:all, :conditions =>  ["data between ? and ?  AND ano_letivo=? ", session[:dataI].to_s, session[:dataF].to_s, Time.now.year], :order => 'data ASC')
            @faltas_professor = AulasFalta.find_by_sql("SELECT professor_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'AND ano_letivo = "+(Time.now.year).to_s+" AND professor_id IS NOT NULL) GROUP BY professor_id")
            @faltas_funcionario = AulasFalta.find_by_sql("SELECT funcionario_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+"  AND funcionario_id IS NOT NULL) GROUP BY funcionario_id")
            @tipo_faltas = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (ano_letivo = "+(Time.now.year).to_s+") GROUP BY tipo")
            @tipo_faltas_mes = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+" ) GROUP BY tipo")
            @aulas_faltas_ano = AulasFalta.find(:all, :conditions =>  ["ano_letivo=? ", Time.now.year], :order => 'data ASC')
            session[:imprimemes] = 1
            session[:imprimeprofessor]  = 0
            session[:imprimefuncionario]= 0
        else
            @aulas_faltas = AulasFalta.find(:all, :conditions =>  ["data between ? and ? AND ano_letivo=? AND unidade_id=?", session[:dataI].to_s, session[:dataF].to_s,  Time.now.year, params[:aulas_falta][:unidade_id]], :order => 'data ASC')
            @faltas_professor = AulasFalta.find_by_sql("SELECT professor_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+" AND professor_id IS NOT NULL) GROUP BY professor_id")
            @faltas_funcionario = AulasFalta.find_by_sql("SELECT funcionario_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+" AND funcionario_id IS NOT NULL) GROUP BY funcionario_id")
            @tipo_faltas = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+") GROUP BY tipo")
            @tipo_faltas_mes = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+") GROUP BY tipo")
            @aulas_faltas_ano = AulasFalta.find(:all, :conditions =>  ["ano_letivo=? AND unidade_id=?", Time.now.year, params[:aulas_falta][:unidade_id]], :order => 'data ASC')
            session[:imprimemes] = 1
            session[:imprimeprofessor]  = 0
            session[:imprimefuncionario]= 0
        end
        render :update do |page|
            page.replace_html 'calendario', :partial => 'faltas'
        end
    end

    def relatorios_faltas_professor
        session[:tiporelatorio]=2
        session[:aulas_falta_professor_id]=params[:aulas_falta][:professor_id]
        session[:verifica_professor_id]=params[:aulas_falta][:professor_id]
        session[:dia_final]=params[:diaF]
        session[:mesF]=params[:mesF]
        session[:dataI]=params[:aulas_falta][:dataI][6,4]+'-'+params[:aulas_falta][:dataI][3,2]+'-'+params[:aulas_falta][:dataI][0,2]
        session[:dataF]=params[:aulas_falta][:dataF][6,4]+'-'+params[:aulas_falta][:dataF][3,2]+'-'+params[:aulas_falta][:dataF][0,2]
        session[:mes]=params[:aulas_falta][:dataF][3,2]
        session[:mostra_falta_professor] = 1
        if session[:mes] == '01'
            session[:mes] = 'JANEIRO'
        else if session[:mes] == '02'
                session[:mes] = 'FEVEREIRO'
            else if session[:mes] == '03'
                    session[:mes] = 'MARÇO'
                else if session[:mes] == '04'
                        session[:mes] = 'ABRIL'
                    else if params[:mes] == '05'
                            session[:mes] = 'MAIO'
                        else if session[:mes] == '06'
                                session[:mes] = 'JUNHO'
                            else if session[:mes] == '07'
                                    session[:mes] = 'JULHO'
                                else if session[:mes] == '08'
                                        session[:mes] = 'AGOSTO'
                                    else if session[:mes] == '09'
                                            session[:mes] = 'SETEMBRO'
                                        else if session[:mes] == '10'
                                                session[:mes] = 'OUTUBRO'
                                            else if session[:mes] == '11'
                                                    session[:mes] = 'NOVEMBRO'
                                                else if session[:mes] == '12'
                                                        session[:mes] = 'DEZEMBRO'
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        @aulas_faltas = AulasFalta.find(:all, :conditions =>  ["data between ? and ? AND ano_letivo=? AND professor_id=?", session[:dataI].to_s, session[:dataF].to_s, Time.now.year, params[:aulas_falta][:professor_id]], :order => 'data ASC')
        @faltas_professor = AulasFalta.find_by_sql("SELECT professor_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND professor_id ="+(session[:verifica_professor_id]).to_s+" AND professor_id IS NOT NULL) GROUP BY professor_id")
        @tipo_faltas_mes = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND professor_id ="+(session[:verifica_professor_id]).to_s+") GROUP BY tipo")
        @tipo_faltas = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (ano_letivo = "+(Time.now.year).to_s+" AND professor_id ="+(session[:verifica_professor_id]).to_s+") GROUP BY tipo")
        @aulas_faltas_ano = AulasFalta.find(:all, :conditions =>  ["ano_letivo=? AND professor_id=?",  Time.now.year, params[:aulas_falta][:professor_id]], :order => 'data ASC')
        session[:imprimeprofessor] = 1
        session[:mostra_faltas_professor] = 1
        session[:imprimemes] = 0
        session[:imprimefuncionario]= 0
        render :update do |page|
            page.replace_html 'calendario', :partial => 'faltas'
        end
    end


    def relatorios_faltas_funcionario
        session[:tiporelatorio]=3
        session[:verifica_funcionario_id]=params[:aulas_falta][:funcionario_id]
        session[:aulas_falta_funcinario_id]=params[:aulas_falta][:funcionario_id]
        session[:dia_final]=params[:diaF]
        session[:mesF]=params[:mesF]
        session[:dataI]=params[:aulas_falta][:dataI][6,4]+'-'+params[:aulas_falta][:dataI][3,2]+'-'+params[:aulas_falta][:dataI][0,2]
        session[:dataF]=params[:aulas_falta][:dataF][6,4]+'-'+params[:aulas_falta][:dataF][3,2]+'-'+params[:aulas_falta][:dataF][0,2]
        session[:mes]=params[:aulas_falta][:dataF][3,2]
        if session[:mes] == '01'
            session[:mes] = 'JANEIRO'
        else if session[:mes] == '02'
                session[:mes] = 'FEVEREIRO'
            else if session[:mes] == '03'
                    session[:mes] = 'MARÇO'
                else if session[:mes] == '04'
                        session[:mes] = 'ABRIL'
                    else if params[:mes] == '05'
                            session[:mes] = 'MAIO'
                        else if session[:mes] == '06'
                                session[:mes] = 'JUNHO'
                            else if session[:mes] == '07'
                                    session[:mes] = 'JULHO'
                                else if session[:mes] == '08'
                                        session[:mes] = 'AGOSTO'
                                    else if session[:mes] == '09'
                                            session[:mes] = 'SETEMBRO'
                                        else if session[:mes] == '10'
                                                session[:mes] = 'OUTUBRO'
                                            else if session[:mes] == '11'
                                                    session[:mes] = 'NOVEMBRO'
                                                else if session[:mes] == '12'
                                                        session[:mes] = 'DEZEMBRO'
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        @aulas_faltas = AulasFalta.find(:all, :conditions =>  ["data between ? and ? AND ano_letivo=? AND funcionario_id=?",  session[:dataI].to_s, session[:dataF].to_s, Time.now.year, params[:aulas_falta][:funcionario_id]], :order => 'data ASC')
        @faltas_funcionario = AulasFalta.find_by_sql("SELECT funcionario_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+" AND funcionario_id ="+(session[:verifica_funcionario_id]).to_s+" AND funcionario_id IS NOT NULL) GROUP BY professor_id")
        @tipo_faltas = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (ano_letivo = "+(Time.now.year).to_s+" AND funcionario_id ="+(session[:verifica_funcionario_id]).to_s+") GROUP BY tipo")
        @tipo_faltas_mes = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND funcionario_id ="+(session[:verifica_funcionario_id]).to_s+") GROUP BY tipo")
        @aulas_faltas_ano = AulasFalta.find(:all, :conditions =>  ["ano_letivo=? AND funcionario_id=?", Time.now.year, params[:aulas_falta][:funcionario_id]], :order => 'data ASC')
        session[:imprimefuncionario] = 1
        session[:mostra_faltas_funcionario] = 1
        session[:imprimemes] = 0
        session[:imprimeprofessor]  = 0
        render :update do |page|
            page.replace_html 'calendario', :partial => 'faltas'
        end
    end


    def impressao_faltas
        if (session[:verifica_unidade_id]=='52')
            @aulas_faltas = AulasFalta.find(:all, :conditions =>  ["data between ? and ?  AND ano_letivo=? ", session[:dataI].to_s, session[:dataF].to_s, Time.now.year], :order => 'data ASC')
            @faltas_professor = AulasFalta.find_by_sql("SELECT professor_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'AND ano_letivo = "+(Time.now.year).to_s+" AND professor_id IS NOT NULL) GROUP BY professor_id")
            @faltas_funcionario = AulasFalta.find_by_sql("SELECT funcionario_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+"  AND funcionario_id IS NOT NULL) GROUP BY funcionario_id")
            @tipo_faltas = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (ano_letivo = "+(Time.now.year).to_s+") GROUP BY tipo")
            @tipo_faltas_mes = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+" ) GROUP BY tipo")
            @aulas_faltas_ano = AulasFalta.find(:all, :conditions =>  ["ano_letivo=? ", Time.now.year], :order => 'data ASC')
        else
            @aulas_faltas = AulasFalta.find(:all, :conditions =>  ["data between ? and ?  AND ano_letivo=? AND unidade_id=?", session[:dataI].to_s, session[:dataF].to_s, Time.now.year, session[:aulas_falta_unidade_id]], :order => 'data ASC')
            @aulas_faltas_ano = AulasFalta.find(:all, :conditions =>  ["ano_letivo=? AND unidade_id=?", Time.now.year, session[:aulas_falta_unidade_id]], :order => 'data ASC')
            @faltas_professor = AulasFalta.find_by_sql("SELECT professor_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+" AND professor_id IS NOT NULL) GROUP BY professor_id")
            @faltas_funcionario = AulasFalta.find_by_sql("SELECT funcionario_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+" AND funcionario_id IS NOT NULL) GROUP BY funcionario_id")
            @tipo_faltas = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+") GROUP BY tipo")
            @tipo_faltas_mes = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+") GROUP BY tipo")
        end

        render :layout => "impressao"
    end

    def impressao_faltas_professor
        @aulas_faltas = AulasFalta.find(:all, :conditions =>  ["data between ? and ?  AND ano_letivo=? AND professor_id=?",session[:dataI].to_s, session[:dataF].to_s, Time.now.year, session[:aulas_falta_professor_id]], :order => 'data ASC')
        @faltas_professor = AulasFalta.find_by_sql("SELECT professor_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND professor_id ="+(session[:verifica_professor_id]).to_s+" AND professor_id IS NOT NULL) GROUP BY professor_id")
        @tipo_faltas_mes = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND professor_id ="+(session[:verifica_professor_id]).to_s+") GROUP BY tipo")
        @tipo_faltas = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (ano_letivo = "+(Time.now.year).to_s+" AND professor_id ="+(session[:verifica_professor_id]).to_s+") GROUP BY tipo")
        @aulas_faltas_ano = AulasFalta.find(:all, :conditions =>  ["ano_letivo=? AND professor_id=?", Time.now.year, session[:aulas_falta_professor_id]], :order => 'data ASC')
        render :layout => "impressao"
    end


    def impressao_faltas_funcionario
        @aulas_faltas = AulasFalta.find(:all, :conditions =>  ["data between ? and ? AND ano_letivo=? AND funcionario_id=?",  session[:dataI].to_s, session[:dataF].to_s, Time.now.year,  session[:verifica_funcionario_id]], :order => 'data ASC')
        @tipo_faltas = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (ano_letivo = "+(Time.now.year).to_s+" AND funcionario_id ="+(session[:verifica_funcionario_id]).to_s+") GROUP BY tipo")
        @tipo_faltas_mes = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND funcionario_id ="+(session[:verifica_funcionario_id]).to_s+") GROUP BY tipo")
        @faltas_funcionario = AulasFalta.find_by_sql("SELECT funcionario_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+" AND funcionario_id ="+(session[:verifica_funcionario_id]).to_s+" AND funcionario_id IS NOT NULL) GROUP BY professor_id")
        @aulas_faltas_ano = AulasFalta.find(:all, :conditions =>  ["ano_letivo=? AND funcionario_id=?", Time.now.year, session[:verifica_funcionario_id]], :order => 'data ASC')
        render :layout => "impressao"
    end


    def classe_professor
        session[:prof_id]=params[:aulas_falta_professor_id]
        @professor_classe= Classe.find_by_sql("SELECT  cla.horario, dis.disciplina as disciplina, cla.classe_classe as classe, atr.ano_letivo FROM "+session[:base]+".classes cla INNER JOIN  "+session[:base]+".atribuicaos atr  ON  cla.id = atr.classe_id INNER JOIN  "+session[:base]+".disciplinas dis  ON  dis.id = atr.disciplina_id WHERE atr.ano_letivo ="+(Time.now.year).to_s+" AND atr.professor_id ="+session[:prof_id].to_s+"")
        session[:profclasse]=@professor_classe[0].classe
        session[:classeper]=@professor_classe[0].horario
        session[:setor]= 'PEDAGÓGICO'
        session[:funcao]= 'PROFESSOR'
         render :partial => 'classeprofessor'
    end

    def setor_funcionario
        session[:func_id]=params[:aulas_falta_funcionario_id]
        @funcionario_setor= Funcionario.find(:all , :select => ['funcao, setor'], :conditions => ['id =?',session[:func_id]])
        session[:profclasse]= nil
        session[:classeper]= nil
        session[:funcao]=@funcionario_setor[0].funcao
        session[:setor]= @funcionario_setor[0].setor
         render :partial => 'setorfuncionario'
    end

  def load_iniciais
         #session[:base]= 'sisgered_development'
         #session[:base]= 'sisgered_production'
        if current_user.has_role?('admin') or current_user.has_role?('SEDUC') or current_user.has_role?('estagiario SEDUC')
            @unidades_infantil = Unidade.find(:all,  :select => 'nome, id',:conditions =>  ["tipo_id = 2 OR tipo_id = 5 OR tipo_id = 8"], :order => 'nome ASC')
            @professores_faltas = Professor.find_by_sql("SELECT distinct(professors.id), professors.nome FROM "+session[:base]+".professors INNER JOIN  "+session[:baseinfo]+".aulas_faltas  ON  professors.id = aulas_faltas.professor_id  WHERE aulas_faltas.ano_letivo = "+(Time.now.year).to_s+" AND aulas_faltas.funcionario_id is null order by professors.nome ASC ")
            @funcionarios_faltas = Funcionario.find_by_sql("SELECT distinct(funcionarios.id), funcionarios.nome FROM funcionarios INNER JOIN  aulas_faltas  ON  funcionarios.id = aulas_faltas.funcionario_id  WHERE aulas_faltas.ano_letivo = "+(Time.now.year).to_s+" AND aulas_faltas.professor_id is null order by funcionarios.nome ASC ")
        else
            @unidades_infantil = Unidade.find(:all,  :select => 'nome, id', :conditions =>  ["id=?", current_user.unidade_id], :order => 'nome ASC')
            @professores_faltas = Professor.find_by_sql("SELECT distinct(professors.id), professors.nome FROM professors INNER JOIN  "+session[:baseinfo]+".aulas_faltas  ON  professors.id = aulas_faltas.professor_id  WHERE aulas_faltas.ano_letivo = "+(Time.now.year).to_s+" AND aulas_faltas.unidade_id = "+(current_user.unidade_id).to_s+" AND aulas_faltas.funcionario_id is null order by professors.nome ASC ")
            @funcionarios_faltas = Funcionario.find_by_sql("SELECT distinct(funcionarios.id), funcionarios.nome FROM funcionarios INNER JOIN  "+session[:baseinfo]+".aulas_faltas  ON  funcionarios.id = aulas_faltas.funcionario_id  WHERE aulas_faltas.ano_letivo = "+(Time.now.year).to_s+" AND aulas_faltas.unidade_id = "+(current_user.unidade_id).to_s+" AND aulas_faltas.professor_id is null order by funcionarios.nome ASC ")
        end
    session[:mostra_faltas_professor] = 0
    session[:mostra_faltas_funcionario] = 0
    end

end
