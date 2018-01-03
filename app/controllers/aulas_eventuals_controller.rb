class AulasEventualsController < ApplicationController
    before_filter :load_iniciais

    def index
        @date = params[:month] ? Date.parse(params[:month]) : Date.today
        @search = AulasEventual.search(params[:search])
        if !(params[:search].blank?)
            @aulas_eventual = @search.all
            @aulas_eventual_unidade = @search.first
        end
       session[:search]=params[:search]
          if !(params[:search].blank?)
              params[:search][:unidade_id_equals]
              @eventual_professor = AulasEventual.find_by_sql("SELECT eventual_id, count( id ) as conta FROM aulas_eventuals WHERE (month( data) = "+@date.strftime("%m")+" AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(params[:search][:unidade_id_equals]).to_s+" ) GROUP BY eventual_id")
           end
    end

   def index2
        if current_user.unidade.tipo_id == 2   or current_user.unidade.tipo_id == 5 or  current_user.unidade.tipo_id == 8
            session[:infantil]= 0
        else
            session[:infantil]= 1
        end
          session[:unidade]= current_user.unidade_id

        @date = params[:month] ? Date.parse(params[:month]) : Date.today
        @search = AulasEventual.search(params[:search])
        if !(params[:search].blank?)
            @aulas_eventual = @search.all
            @aulas_eventual_unidade = @search.first
        end

       
        session[:professor] =1
        session[:funcionario] =0

  end

  def destroy
        @aulas_eventual = AulasEventual.find(params[:id])
        @aulas_eventual.destroy
        respond_to do |format|
            format.html { redirect_to(aulas_eventuals_url) }
            format.xml  { head :ok }
        end
    end

   def show
        @aulas_eventual = AulasEventual.find(params[:id])
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @aulas_eventual }
        end
    end

    def new
        @aulas_eventual = AulasEventual.new
        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @aulas_eventual }
        end
    end

    def edit
        @aulas_eventual = AulasEventual.find(params[:id])
    end

    def create
        @aulas_eventual = AulasEventual.new(params[:aulas_eventual])
        @aulas_eventual.ano_letivo = Time.now.year
        @aulas_eventual.aulas_falta_id= session[:falta_id]
        respond_to do |format|
            if @aulas_eventual.save
                flash[:notice] = 'SALVO COM SUCESSO.'
                format.html { redirect_to(@aulas_eventual) }
                format.xml  { render :xml => @aulas_eventual, :status => :created, :location => @aulas_eventual }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @aulas_eventual.errors, :status => :unprocessable_entity }
            end
        end
    end

    def update
        @aulas_eventual = AulasEventual.find(params[:id])
        respond_to do |format|
            if @aulas_eventual.update_attributes(params[:aulas_eventual])
                flash[:notice] = 'SALVO COM SUCESSO.'
                format.html { redirect_to(@aulas_eventual) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @aulas_eventual.errors, :status => :unprocessable_entity }
            end
        end
    end


def data_eventual
    session[:aulas_eventual_data]=  params[:aulas_eventual_data][6,4]+'-'+params[:aulas_eventual_data][3,2]+'-'+params[:aulas_eventual_data][0,2]
end

def periodo_prof_eventual
    session[:periodo_prof_eventual]=  params[:periodo]
end

def caregoria_prof_eventual
    session[:caregoria_prof_eventual]=  params[:categoria]
end

def nome_prof_eventual
         @date = params[:month] ? Date.parse(params[:month]) : Date.today
        session[:aulas_eventual_unidade_id]=params[:aulas_eventual_unidade_id]
        @professores1= Eventual.find_by_sql("SELECT pro.id, pro.nome, eve.id FROM eventuals eve INNER JOIN "+session[:base]+".professors pro ON eve.professor_id = pro.id INNER JOIN  "+session[:base]+".unidades uni ON  uni.id = pro.unidade_id  WHERE eve.periodo = '"+session[:periodo_prof_eventual]+"' AND eve.categoria = '"+session[:caregoria_prof_eventual]+"'AND eve.unidade_id = "+session[:aulas_eventual_unidade_id]+" AND eve.id NOT IN (SELECT aulas_eventuals.eventual_id FROM aulas_eventuals WHERE aulas_eventuals.ano_letivo ="+(Time.now.year).to_s+" AND data = '"+session[:aulas_eventual_data].to_s+"' AND aulas_eventuals.unidade_id = "+session[:aulas_eventual_unidade_id]+" order by uni.regiao_id ASC ) order by uni.regiao_id ASC")
        @divisao=Eventual.find_by_sql("SELECT eve.id, pro.nome FROM eventuals eve INNER JOIN  "+session[:base]+".professors pro ON  pro.id = eve.professor_id")

        @divisao[0].nome="----------------------------------"
        @divisao[0].id = 0
        @professores2 = Eventual.find_by_sql("SELECT eve.id, pro.nome FROM eventuals eve INNER JOIN  "+session[:base]+".professors pro  ON  pro.id = eve.professor_id INNER JOIN  "+session[:base]+".unidades  uni ON  uni.id = pro.unidade_id WHERE eve.periodo = '"+session[:periodo_prof_eventual]+"' AND eve.categoria = '"+session[:caregoria_prof_eventual]+"'AND eve.unidade_id != "+session[:aulas_eventual_unidade_id]+" AND eve.id NOT IN (SELECT aulas_eventuals.eventual_id FROM aulas_eventuals WHERE aulas_eventuals.ano_letivo ="+(Time.now.year).to_s+" AND data = '"+session[:aulas_eventual_data].to_s+"' AND aulas_eventuals.unidade_id = "+session[:aulas_eventual_unidade_id]+" order by uni.regiao_id ASC ) order by uni.regiao_id ASC,  pro.nome ASC")
        @professores = @professores1 + @divisao + @professores2
        @classes = Classe.find(:all,:select => 'id, classe_classe', :conditions =>['unidade_id =? and  classe_ano_letivo=?',  session[:aulas_eventual_unidade_id], Time.now.year], :order => 'classe_classe')
        @interno= Eventual.find_by_sql("SELECT aulas_eventuals.eventual_id FROM aulas_eventuals WHERE aulas_eventuals.ano_letivo ="+(Time.now.year).to_s+" AND data = '"+session[:aulas_eventual_data].to_s+"' AND aulas_eventuals.unidade_id = "+session[:aulas_eventual_unidade_id]+" " )
        @prof_falta = Professor.find_by_sql("SELECT pro.id, pro.nome FROM professors pro INNER JOIN  "+session[:baseinfo]+".aulas_faltas fal  ON  pro.id = fal.professor_id WHERE  fal.unidade_id = "+session[:aulas_eventual_unidade_id]+" AND fal.data = "+'"'+ session[:aulas_eventual_data]+'"' +" AND fal.ano_letivo ="+(Time.now.year).to_s+" order by pro.nome ASC")
        if @professores.present?
           render :partial => 'selecao_professor'
        else
           render :partial => 'aviso'
        end
    end


def aulas_faltas_prof_classe
  session[:professor_id] = params[:aulas_eventual_professor_id]
   @aula_falta= AulasFalta.find(:all, :conditions => ['professor_id=? AND data =?', params[:aulas_eventual_professor_id], session[:aulas_eventual_data]] )
   session[:falta_id]= @aula_falta[0].id
       render :partial => 'proffalta'
end


    def observacao_prof_eventual
        @professor = Eventual.find(:all, :conditions => ['id = ?',  params[:aulas_eventual_eventual_id]] )
        render :partial => 'observacaos'
    end


    def impressao_unidade
         @date = params[:month] ? Date.parse(params[:month]) : Date.today
        @search = AulasEventual.search(session[:search])
        if !(session[:search].blank?)
            @aulas_eventual = @search.all
            @aulas_eventual_unidade = @search.first
        end

       render :layout => "impressao"
    end

def relatorios_eventual_professor
    session[:tiporelatorio]=2
    session[:aulas_professor_id]=params[:aulas_eventual][:eventual_id]
    session[:verifica_professor_id]=params[:aulas_eventual][:eventual_id]
    session[:dia_final]=params[:diaF]
    session[:mesF]=params[:mesF]
    session[:dataI]=params[:aulas_falta][:dataI][6,4]+'-'+params[:aulas_falta][:dataI][3,2]+'-'+params[:aulas_falta][:dataI][0,2]
    session[:dataF]=params[:aulas_falta][:dataF][6,4]+'-'+params[:aulas_falta][:dataF][3,2]+'-'+params[:aulas_falta][:dataF][0,2]
    session[:mes]=params[:aulas_falta][:dataF][3,2]
    session[:mostra_eventual_professor] = 1
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
    @aulas_eventuals = AulasEventual.find(:all, :conditions =>  ["data between ? and ? AND ano_letivo=? AND eventual_id=?", session[:dataI].to_s, session[:dataF].to_s, Time.now.year, params[:aulas_eventual][:eventual_id]], :order => 'data ASC')
    @eventual_professor = AulasEventual.find_by_sql("SELECT eventual_id, count( id ) as conta FROM aulas_eventuals WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+" AND eventual_id ="+(session[:verifica_professor_id]).to_s+" ) GROUP BY eventual_id")
    session[:imprimeprofessor] = 1
    session[:mostra_faltas_professor] = 1
       render :update do |page|
          page.replace_html 'calendario', :partial => 'eventuals'
       end
end


 def relatorios_eventuals
    session[:tiporelatorio]=1
    session[:dia_final]=params[:diaF]
    session[:mesF]=params[:mesF]
    session[:dataI]=params[:aulas_falta][:dataI][6,4]+'-'+params[:aulas_falta][:dataI][3,2]+'-'+params[:aulas_falta][:dataI][0,2]
    session[:dataF]=params[:aulas_falta][:dataF][6,4]+'-'+params[:aulas_falta][:dataF][3,2]+'-'+params[:aulas_falta][:dataF][0,2]
    session[:mes]=params[:aulas_falta][:dataF][3,2]
    session[:verifica_unidade_id]=params[:aulas_eventual][:unidade_id]
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
    session[:mostra_eventuals_professor] = 1
    session[:aulas_eventual_unidade_id] = params[:aulas_eventual][:unidade_id]
     if (session[:verifica_unidade_id]=='52')
         @aulas_eventuals = AulasEventual.find(:all, :conditions =>  ["data between ? and ?  AND ano_letivo=? ", session[:dataI].to_s, session[:dataF].to_s, Time.now.year], :order => 'data ASC')
         @eventual_professor = AulasEventual.find_by_sql("SELECT eventual_id, count( id ) as conta FROM aulas_eventuals WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND eventual_id IS NOT NULL) GROUP BY eventual_id")
         session[:imprimemes] = 1
     else
         @aulas_eventuals = AulasEventual.find(:all, :conditions =>  ["data between ? and ? AND ano_letivo=? AND unidade_id=?", session[:dataI].to_s, session[:dataF].to_s, Time.now.year, params[:aulas_eventual][:unidade_id]], :order => 'data ASC')
         @eventual_professor = AulasEventual.find_by_sql("SELECT eventual_id, count( id ) as conta FROM aulas_eventuals WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+" AND eventual_id IS NOT NULL) GROUP BY eventual_id")
         session[:imprimemes] = 1
     end
       render :update do |page|
           page.replace_html 'calendario', :partial => 'eventuals'
       end
end

def impressao_eventuals
     if (session[:verifica_unidade_id]=='52')
         @aulas_eventuals = AulasEventual.find(:all, :conditions =>  ["data between ? and ? AND ano_letivo=? ", session[:dataI].to_s, session[:dataF].to_s, Time.now.year], :order => 'data ASC')
         @eventuals_professor = AulasEventual.find_by_sql("SELECT eventual_id, count( id ) as conta FROM aulas_eventuals WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND eventual_id IS NOT NULL) GROUP BY eventual_id")
     else
         @aulas_eventuals = AulasEventual.find(:all, :conditions =>  ["data between ? and ? AND  ano_letivo=? AND unidade_id=?",session[:dataI].to_s, session[:dataF].to_s, Time.now.year, session[:aulas_eventual_unidade_id]], :order => 'data ASC')
         @eventuals_professor = AulasEventual.find_by_sql("SELECT eventual_id, count( id ) as conta FROM aulas_eventuals WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND unidade_id ="+(session[:verifica_unidade_id]).to_s+" AND eventual_id IS NOT NULL) GROUP BY eventual_id")
     end
    render :layout => "impressao"
end

def impressao_eventuals_professor
    session[:verifica_professor_id]
    @aulas_eventuals = AulasEventual.find(:all, :conditions =>  ["data between ? and ? AND ano_letivo=? AND eventual_id=?", session[:dataI].to_s, session[:dataF].to_s, Time.now.year,  session[:verifica_professor_id]], :order => 'data ASC')
    @eventual_professor = AulasEventual.find_by_sql("SELECT eventual_id, count( id ) as conta FROM aulas_eventuals WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+" AND eventual_id ="+(session[:verifica_professor_id]).to_s+" AND eventual_id IS NOT NULL ) GROUP BY eventual_id")
    render :layout => "impressao"
end

def load_iniciais
    #session[:base]= 'sisgered_development'
     session[:base]= 'sisgered_production'
         if current_user.has_role?('admin') or current_user.has_role?('SEDUC')
            @unidades_infantil = Unidade.find(:all,  :select => 'nome, id',:conditions =>  ["tipo_id = 2 OR tipo_id = 5 OR tipo_id = 8"], :order => 'nome ASC')
            @professores_eventual= AulasEventual.find_by_sql("SELECT DISTINCT(pro.id), pro.nome, eve.id FROM aulas_eventuals aev LEFT JOIN  eventuals eve ON aev.eventual_id = eve.id LEFT JOIN "+session[:base]+".professors pro ON eve.professor_id = pro.id WHERE eve.ano_letivo = "+(Time.now.year).to_s+" ORDER BY pro.nome")
         else
            @unidades_infantil = Unidade.find(:all,  :select => 'nome, id', :conditions =>  ["id=?", current_user.unidade_id], :order => 'nome ASC')
            @professores_eventual= AulasEventual.find_by_sql("SELECT DISTINCT(pro.id), pro.nome, eve.id FROM aulas_eventuals aev LEFT JOIN  eventuals eve ON aev.eventual_id = eve.id LEFT JOIN "+session[:base]+".professors pro ON eve.professor_id = pro.id WHERE eve.ano_letivo = "+(Time.now.year).to_s+"  AND aev.unidade_id = "+(current_user.unidade_id).to_s+"  ORDER BY pro.nome")
         end
      @professores_eventual_infantil= Eventual.find_by_sql("SELECT pro.id, pro.nome, eve.id FROM eventuals eve LEFT JOIN "+session[:base]+".professors pro ON eve.professor_id = pro.id WHERE eve.ano_letivo = 'Time.now.year).to_s +' ORDER BY pro.nome")
    end
end