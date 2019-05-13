class MmanutencaosController < ApplicationController
 #before_filter :load_tipomanutencaos
 #before_filter :load_unidades
 #before_filter :load_funcionarios
 #before_filter :load_situacaos
 #before_filter :load_chefias


 #def load_funcionarios
                    # session[:base]= 'sisgered_development'
                     #session[:base]= 'sisgered_production'
 #  if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao')
 #     @funcionarios = Funcionario.find(:all,:conditions => ['desligado=?',0], :order => 'nome ASC' )
 #  else
 #      @funcionarios = Funcionario.find(:all, :conditions => ['desligado=?',0], :order => 'nome ASC' )
 #  end
 #     if current_user.unidade_id == 52 or current_user.unidade_id == 53
 #          @protocolos = Mmanutencao.find(:all, :conditions =>['situacao_manutencao_id != 2'], :order => 'id ASC')
 #     else
 #         @protocolos = Mmanutencao.find(:all, :conditions =>['unidade_id =? AND situacao_manutencao_id != 2', current_user.unidade_id], :order => 'id ASC')
 #     end
 # end

  #def load_chefias
  #  t=0
  #  @chefias1 = Chefia.find(:all,  :conditions => ['desligado=? ',0], :order => 'nome ASC')
  #end

  #def load_situacaos
  #    t=0
  #  @situacaos = SituacaoManutencao.find(:all)
  #end


 # def load_tipomanutencaos
  #  t=0
 #      @tipos_manutencaos =  TiposManutencao.find(:all)
 #  end

#   def load_unidades
#   if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao')
 #      @unidades_manutencao =  Unidade.find(:all, :order => 'nome ASC')
#      else
#        if (current_user.unidade_id== 53)
#           @unidades_manutencao =  Unidade.find(:all, :order => 'nome ASC')
#        else
#          @unidades_manutencao =  Unidade.find(:all, :conditions => ['id = ?',current_user.unidade_id ],:order => 'nome ASC')
#        end
#    end
#     @unidades =  Unidade.find(:all, :order => 'nome ASC')
#   end

 def index

    if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao') or current_user.has_role?('SEDUC')
      #  @mmanutencaos_abertas = Mmanutencao.all(:conditions => ["situacao_manutencao_id <> 2"])
        @mmanutencaos_unidade = Mmanutencao.find_by_sql("SELECT uni.nome AS nome, mma.id, mma.unidade_id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <>2 ORDER BY mma.data_sol DESC")
    else
      if current_user.has_role?('diretor_unidade')
   #     @mmanutencaos = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <> 2 ORDER BY mma.data_sol DESC")
   #     @mmanutencaos_abertas = Mmanutencao.all(:conditions => ["situacao_manutencao_id <> 2"])
         @mmanutencaos_unidade = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <> 2 and mma.unidade_id ="+(current_user.unidade_id).to_s+" ORDER BY mma.data_sol DESC")
      else if current_user.has_role?('terceiro')
   #      @mmanutencaos = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <> 2 ORDER BY mma.data_sol DESC")
   #     @mmanutencaos_abertas = Mmanutencao.all(:conditions => ["situacao_manutencao_id <> 2"])
        @mmanutencaos_unidade = Mmanutencao.find_by_sql("SELECT uni.nome AS nome, mma.id, mma.unidade_id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <>2 and (chefia_id = 12 or chefia_id = 13) ORDER BY mma.data_sol DESC")
          else
            #   @mmanutencaos_abertas = Mmanutencao.all(:conditions => ["situacao_manutencao_id <> 2"])
                @mmanutencaos_unidade = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <> 2 and mma.unidade_id ="+(current_user.unidade_id).to_s+" ORDER BY mma.data_sol DESC")
          end
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mmanutencaos }
    end
  end

 def estatistica
    if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao')
       @mmanutencaos = Mmanutencao.all(:conditions =>  "situacao_manutencao_id <> 2")
       @mmanutencaos_todos= Mmanutencao.all
    else
      if current_user.has_role?('diretor_unidade')
       @mmanutencaos = Mmanutencao.all(:conditions =>["situacao_manutencao_id <> 2 and unidade_id = ?",current_user.unidade_id ])
      else
       @mmanutencaos = Mmanutencao.all(:conditions =>["situacao_manutencao_id <> 2 and user_id = ?",current_user])
       $chefia1=@mmanutencaos.user_id.current_user
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mmanutencaos }
    end
  end

def relatorios
end

 def relatorios_manutencaos

   w = session[:dataI]=params[:manutecao][:dataI][6,4]+'-'+params[:manutecao][:dataI][3,2]+'-'+params[:manutecao][:dataI][0,2]
   w2= session[:dataF]=params[:manutecao][:dataF][6,4]+'-'+params[:manutecao][:dataF][3,2]+'-'+params[:manutecao][:dataF][0,2]
w3=params[:manutencao][:situacao_manutencao_id]
    @mmanutencaos = Mmanutencao.find(:all, :joins= [:tipos_manuntecaos], :conditions =>["(mmanutencaos.data_sol >= ? AND ?) AND tipos_manutencaos.tipos_manutencao_id =? ",session[:dataI], session[:data], params[:manutencao][:situacao_manutencao_id] ])


     render :update do |page|
            page.replace_html 'relatorio', :partial => 'relatorio'
     end




      session[:dia_final]=params[:diaF]
      session[:mesF]=params[:mesF]
      session[:dataI]=params[:aulas_falta][:dataI][6,4]+'-'+params[:aulas_falta][:dataI][3,2]+'-'+params[:aulas_falta][:dataI][0,2]
      session[:dataF]=params[:aulas_falta][:dataF][6,4]+'-'+params[:aulas_falta][:dataF][3,2]+'-'+params[:aulas_falta][:dataF][0,2]
      session[:mes]=params[:aulas_falta][:dataF][3,2]



 @mmanutencaos





        session[:tiporelatorio]=1
        session[:professor_id]=params[:aulas_falta][:professor_id]
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
            session[:imprimedia] = 1
            session[:imprimemes] = 0
            session[:imprimeprofessor]  = 0
            session[:imprimefuncionario]= 0
        else
            @aulas_faltas = AulasFalta.find(:all, :conditions =>  ["data between ? and ? AND ano_letivo=? ", session[:dataI].to_s, session[:dataF].to_s,  Time.now.year ], :order => 'data ASC')
            @faltas_professor = AulasFalta.find_by_sql("SELECT professor_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+"  AND professor_id IS NOT NULL) GROUP BY professor_id")
            @faltas_funcionario = AulasFalta.find_by_sql("SELECT funcionario_id, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"' AND ano_letivo = "+(Time.now.year).to_s+" AND funcionario_id IS NOT NULL) GROUP BY funcionario_id")
            @tipo_faltas = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (ano_letivo = "+(Time.now.year).to_s+") GROUP BY tipo")
            @tipo_faltas_mes = AulasFalta.find_by_sql("SELECT tipo, count( id ) as conta FROM aulas_faltas WHERE (data BETWEEN '"+session[:dataI]+"' AND '"+session[:dataF]+"'  AND ano_letivo = "+(Time.now.year).to_s+" ) GROUP BY tipo")
            @aulas_faltas_ano = AulasFalta.find(:all, :conditions =>  ["ano_letivo=? AND unidade_id=?", Time.now.year, params[:aulas_falta][:unidade_id]], :order => 'data ASC')
            session[:imprimedia] = 1
            session[:imprimemes] = 0
            session[:imprimeprofessor]  = 0
            session[:imprimefuncionario]= 0
        end
        render :update do |page|
            page.replace_html 'calendario', :partial => 'faltas'
        end

    end


 def estatisticasM
   session[:nome_manutencao1]= 'em '+(Date.today.strftime("%B"))
   if (params[:estatisticas].to_i == 1)
      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 1 and created_at > ?", $data])
      session[:nome_manutencao]= 'ALVENARIA'
      render "estatisticasM"
   else if (params[:estatisticas].to_i == 2)
           @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 3 and created_at > ?", $data])
           session[:nome_manutencao]= 'DEDETIZAÇÂO'
           render "estatisticasM"
        else if (params[:estatisticas].to_i == 3)
              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 4 and created_at > ?", $data])
              session[:nome_manutencao]= 'ELETRODOMÉSTICOS'
              render "estatisticasM"
             else if (params[:estatisticas].to_i == 4)
                   @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 5 and created_at > ?", $data])
                   session[:nome_manutencao]= 'ELÉTRICA'
                   render "estatisticasM"
                  else if (params[:estatisticas].to_i == 5)
                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 6 and created_at > ?", $data])
                        session[:nome_manutencao]= 'MATERIAL DE COZINHA'
                        render "estatisticasM"
                       else if (params[:estatisticas].to_i == 6)
                             @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 7 and created_at > ?", $data])
                             session[:nome_manutencao]= 'HIDRÁULICA'
                             render "estatisticasM"
                            else if (params[:estatisticas].to_i == 7)
                                  @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 9 and created_at > ?", $data])
                                  session[:nome_manutencao]= 'MARCENARIA'
                                  render "estatisticasM"
                                  else if (params[:estatisticas].to_i == 8)
                                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 10 and created_at > ?", $data])
                                        session[:nome_manutencao]= 'PINTURA'
                                        render "estatisticasM"
                                        else if (params[:estatisticas].to_i == 9)
                                              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 8 and created_at > ?", $data])
                                              session[:nome_manutencao]= "LIMPEZA CAIXA D'AGUA"
                                              render "estatisticasM"
                                              else if (params[:estatisticas].to_i == 10)
                                                    @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 11 and created_at > ?", $data])
                                                    session[:nome_manutencao]= "PLAYGROUND"
                                                    render "estatisticasM"
                                                    else if (params[:estatisticas].to_i == 11)
                                                          @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 13 and created_at > ?", $data])
                                                          session[:nome_manutencao]= "SERRALHERIA"
                                                          render "estatisticasM"
                                                          else if (params[:estatisticas].to_i == 12)
                                                                @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 14 and created_at > ?", $data])
                                                                session[:nome_manutencao]= "TELHADO"
                                                                render "estatisticasM"
                                                                else if (params[:estatisticas].to_i == 13)
                                                                      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 12 and created_at > ?", $data])
                                                                      session[:nome_manutencao]= "PODA DE GRAMA"
                                                                      render "estatisticasM"
                                                                      else if (params[:estatisticas].to_i == 14)
                                                                            @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 15 and created_at > ?", $data])
                                                                            session[:nome_manutencao]= "OUTROS SERVIÇOS"
                                                                            render "estatisticasM"
                                                                            else

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
        end
   end
 end


 def estatisticasMA
   session[:nome_manutencao1]= 'EM ABERTO em '+(Date.today.strftime("%B"))
   if (params[:estatisticas].to_i == 1)
      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id=1 and situacao_manutencao_id=1 and created_at > ?", $data])
      session[:nome_manutencao]= 'ALVENARIA'
      render "estatisticasM"
   else if (params[:estatisticas].to_i == 2)
           @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 3 and situacao_manutencao_id=1 and created_at > ?", $data])
           session[:nome_manutencao]= 'DEDETIZAÇÂO'
           render "estatisticasM"
        else if (params[:estatisticas].to_i == 3)
              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 4 and situacao_manutencao_id=1 and created_at > ?", $data])
              session[:nome_manutencao]= 'ELETRODOMÉSTICOS'
              render "estatisticasM"
             else if (params[:estatisticas].to_i == 4)
                   @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 5 and situacao_manutencao_id=1 and created_at > ?", $data])
                   session[:nome_manutencao]= 'ELÉTRICA'
                   render "estatisticasM"
                  else if (params[:estatisticas].to_i == 5)
                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 6 and situacao_manutencao_id=1 and created_at > ?", $data])
                        session[:nome_manutencao]= 'MATERIAL DE COZINHA'
                        render "estatisticasM"
                       else if (params[:estatisticas].to_i == 6)
                             @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 7 and situacao_manutencao_id=1 and created_at > ?", $data])
                             session[:nome_manutencao]= 'HIDRÁULICA'
                             render "estatisticasM"
                            else if (params[:estatisticas].to_i == 7)
                                  @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 9 and situacao_manutencao_id=1 and created_at > ?", $data])
                                  session[:nome_manutencao]= 'MARCENARIA'
                                  render "estatisticasM"
                                  else if (params[:estatisticas].to_i == 8)
                                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 10 and situacao_manutencao_id=1 and created_at > ?", $data])
                                        session[:nome_manutencao]= 'PINTURA'
                                        render "estatisticasM"
                                        else if (params[:estatisticas].to_i == 9)
                                              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 8 and situacao_manutencao_id=1 and created_at > ?", $data])
                                              session[:nome_manutencao]= "LIMPEZA CAIXA D'AGUA"
                                              render "estatisticasM"
                                              else if (params[:estatisticas].to_i == 10)
                                                    @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 11 and situacao_manutencao_id=1 and created_at > ?", $data])
                                                    session[:nome_manutencao]= "PLAYGROUND"
                                                    render "estatisticasM"
                                                    else if (params[:estatisticas].to_i == 11)
                                                          @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 13 and situacao_manutencao_id=1 and created_at > ?", $data])
                                                          session[:nome_manutencao]= "SERRALHERIA"
                                                          render "estatisticasM"
                                                          else if (params[:estatisticas].to_i == 12)
                                                                @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 14 and situacao_manutencao_id=1 and created_at > ?", $data])
                                                                session[:nome_manutencao]= "TELHADO"
                                                                render "estatisticasM"
                                                                else if (params[:estatisticas].to_i == 13)
                                                                      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 12 and situacao_manutencao_id=1 and created_at > ?", $data])
                                                                      session[:nome_manutencao]= "PODA GRAMA"
                                                                      render "estatisticasM"
                                                                      else if (params[:estatisticas].to_i == 14)
                                                                            @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 15 and situacao_manutencao_id=1 and created_at > ?", $data])
                                                                            session[:nome_manutencao]= "OUTROS SERVIÇOS"
                                                                            render "estatisticasM"
                                                                            else
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
        end
   end
  end

 def estatisticasME
   session[:nome_manutencao1]= 'ENCERRADO em '+(Date.today.strftime("%B"))
   if (params[:estatisticas].to_i == 1)
      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id=1 and situacao_manutencao_id=2 and created_at > ?", $data])
      session[:nome_manutencao]= 'ALVENARIA'
      render "estatisticasM"
   else if (params[:estatisticas].to_i == 2)
           @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 3 and situacao_manutencao_id=2 and created_at > ?", $data])
           session[:nome_manutencao]= 'DEDETIZAÇÂO'
           render "estatisticasM"
        else if (params[:estatisticas].to_i == 3)
              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 4 and situacao_manutencao_id=2 and created_at > ?", $data])
              session[:nome_manutencao]= 'ELETRODOMÉSTICOS'
              render "estatisticasM"
             else if (params[:estatisticas].to_i == 4)
                   @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 5 and situacao_manutencao_id=2 and created_at > ?", $data])
                   session[:nome_manutencao]= 'ELÉTRICA'
                   render "estatisticasM"
                  else if (params[:estatisticas].to_i == 5)
                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 6 and situacao_manutencao_id=2 and created_at > ?", $data])
                        session[:nome_manutencao]= 'MATERIAL DE COZINHA'
                        render "estatisticasM"
                       else if (params[:estatisticas].to_i == 6)
                             @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 7 and situacao_manutencao_id=2 and created_at > ?", $data])
                             session[:nome_manutencao]= 'HIDRÁULICA'
                             render "estatisticasM"
                            else if (params[:estatisticas].to_i == 7)
                                  @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 9 and situacao_manutencao_id=2 and created_at > ?", $data])
                                  session[:nome_manutencao]= 'MARCENARIA'
                                  render "estatisticasM"
                                  else if (params[:estatisticas].to_i == 8)
                                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 10 and situacao_manutencao_id=2 and created_at > ?", $data])
                                        session[:nome_manutencao]= 'PINTURA'
                                        render "estatisticasM"
                                        else if (params[:estatisticas].to_i == 9)
                                              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 8 and situacao_manutencao_id=2 and created_at > ?", $data])
                                              session[:nome_manutencao]= "LIMPEZA CAIXA D'AGUA"
                                              render "estatisticasM"
                                              else if (params[:estatisticas].to_i == 10)
                                                    @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 11 and situacao_manutencao_id=2 and created_at > ?", $data])
                                                    session[:nome_manutencao]= "PLAYGROUND"
                                                    render "estatisticasM"
                                                    else if (params[:estatisticas].to_i == 11)
                                                          @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 13 and situacao_manutencao_id=2 and created_at > ?", $data])
                                                          session[:nome_manutencao]= "SERRALHERIA"
                                                          render "estatisticasM"
                                                          else if (params[:estatisticas].to_i == 12)
                                                                @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 14 and situacao_manutencao_id=2 and created_at > ?", $data])
                                                                session[:nome_manutencao]= "TELHADO"
                                                                render "estatisticasM"
                                                                else if (params[:estatisticas].to_i == 13)
                                                                      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 12 and situacao_manutencao_id=2 and created_at > ?", $data])
                                                                      session[:nome_manutencao]= "PODA GRAMA"
                                                                      render "estatisticasM"
                                                                      else if (params[:estatisticas].to_i == 14)
                                                                            @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 15 and situacao_manutencao_id=2 and created_at > ?", $data])
                                                                            session[:nome_manutencao]= "OUTROS SERVIÇOS"
                                                                            render "estatisticasM"
                                                                            else
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
        end
   end
 
 end

 def estatisticasMAt
   session[:nome_manutencao1]= 'EM ATENDIMENTO em '+(Date.today.strftime("%B"))
   if (params[:estatisticas].to_i == 1)
      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id=1 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
      session[:nome_manutencao]= 'ALVENARIA'
      render "estatisticasM"
   else if (params[:estatisticas].to_i == 2)
           @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 3 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
           session[:nome_manutencao]= 'DEDETIZAÇÂO'
           render "estatisticasM"
        else if (params[:estatisticas].to_i == 3)
              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 4 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
              session[:nome_manutencao]= 'ELETRODOMÉSTICOS'
              render "estatisticasM"
             else if (params[:estatisticas].to_i == 4)
                   @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 5 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                   session[:nome_manutencao]= 'ELÉTRICA'
                   render "estatisticasM"
                  else if (params[:estatisticas].to_i == 5)
                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 6 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                        session[:nome_manutencao]= 'MATERIAL DE COZINHA'
                        render "estatisticasM"
                       else if (params[:estatisticas].to_i == 6)
                             @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 7 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                             session[:nome_manutencao]= 'HIDRÁULICA'
                             render "estatisticasM"
                            else if (params[:estatisticas].to_i == 7)
                                  @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 9 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                                  session[:nome_manutencao]= 'MARCENARIA'
                                  render "estatisticasM"
                                  else if (params[:estatisticas].to_i == 8)
                                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 10 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                                        session[:nome_manutencao]= 'PINTURA'
                                        render "estatisticasM"
                                        else if (params[:estatisticas].to_i == 9)
                                              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 8 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                                              session[:nome_manutencao]= "LIMPEZA CAIXA D'AGUA"
                                              render "estatisticasM"
                                              else if (params[:estatisticas].to_i == 10)
                                                    @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 11 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                                                    session[:nome_manutencao]= "PLAYGROUND"
                                                    render "estatisticasM"
                                                    else if (params[:estatisticas].to_i == 11)
                                                          @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 13 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                                                          session[:nome_manutencao]= "SERRALHERIA"
                                                          render "estatisticasM"
                                                          else if (params[:estatisticas].to_i == 12)
                                                                @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 14 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                                                                session[:nome_manutencao]= "TELHADO"
                                                                render "estatisticasM"
                                                                else if (params[:estatisticas].to_i == 13)
                                                                      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 12 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                                                                      session[:nome_manutencao]= "PODA GRAMA"
                                                                      render "estatisticasM"
                                                                      else if (params[:estatisticas].to_i == 14)
                                                                            @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 15 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ?", $data])
                                                                            session[:nome_manutencao]= "OUTROS SERVIÇOS"
                                                                            
                                                                            render "estatisticasM"
                                                                            else

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
        end
   end
 end


 def estatisticasMANT
   session[:nome_manutencao1]= 'em '+((Date.today<<1).strftime("%B"))
   if (params[:estatisticas].to_i == 1)
      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 1 and created_at > ? and created_at < ?", $datai, $dataf])
      session[:nome_manutencao]= 'ALVENARIA'
      render "estatisticasM"
   else if (params[:estatisticas].to_i == 2)
           @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 3 and created_at > ? and created_at < ?", $datai, $dataf])
           session[:nome_manutencao]= 'DEDETIZAÇÂO'
           render "estatisticasM"
        else if (params[:estatisticas].to_i == 3)
              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 4 and created_at > ? and created_at < ?", $datai, $dataf])
              session[:nome_manutencao]= 'ELETRODOMÉSTICOS'
              render "estatisticasM"
             else if (params[:estatisticas].to_i == 4)
                   @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 5 and created_at > ? and created_at < ?", $datai, $dataf])
                   session[:nome_manutencao]= 'ELÉTRICA'
                   render "estatisticasM"
                  else if (params[:estatisticas].to_i == 5)
                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 6 and created_at > ? and created_at < ?", $datai, $dataf])
                        session[:nome_manutencao]= 'MATERIAL DE COZINHA'
                        render "estatisticasM"
                       else if (params[:estatisticas].to_i == 6)
                             @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 7 and created_at > ? and created_at < ?", $datai, $dataf])
                             session[:nome_manutencao]= 'HIDRÁULICA'
                             render "estatisticasM"
                            else if (params[:estatisticas].to_i == 7)
                                  @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 9 and created_at > ? and created_at < ?", $datai, $dataf])
                                  session[:nome_manutencao]= 'MARCENARIA'
                                  render "estatisticasM"
                                  else if (params[:estatisticas].to_i == 8)
                                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 10 and created_at > ? and created_at < ?", $datai, $dataf])
                                        session[:nome_manutencao]= 'PINTURA'
                                        render "estatisticasM"
                                        else if (params[:estatisticas].to_i == 9)
                                              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 8 and created_at > ? and created_at < ?", $datai, $dataf])
                                              session[:nome_manutencao]= "LIMPEZA CAIXA D'AGUA"
                                              render "estatisticasM"
                                              else if (params[:estatisticas].to_i == 10)
                                                    @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 11 and created_at > ? and created_at < ?", $datai, $dataf])
                                                    session[:nome_manutencao]= "PLAYGROUND"
                                                    render "estatisticasM"
                                                    else if (params[:estatisticas].to_i == 11)
                                                          @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 13 and created_at > ? and created_at < ?", $datai, $dataf])
                                                          session[:nome_manutencao]= "SERRALHERIA"
                                                          render "estatisticasM"
                                                          else if (params[:estatisticas].to_i == 12)
                                                                @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 14 and created_at > ? and created_at < ?", $datai, $dataf])
                                                                session[:nome_manutencao]= "TELHADO"
                                                                render "estatisticasM"
                                                                else if (params[:estatisticas].to_i == 13)
                                                                      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 12 and created_at > ? and created_at < ?", $datai, $dataf])
                                                                      session[:nome_manutencao]= "PODA DE GRAMA"
                                                                      render "estatisticasM"
                                                                      else if (params[:estatisticas].to_i == 14)
                                                                            @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 15 and created_at > ? and created_at < ?", $datai, $dataf])
                                                                            session[:nome_manutencao]= "OUTROS SERVIÇOS"
                                                                            render "estatisticasM"
                                                                            else

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
        end
   end
 end


 def estatisticasMANTA
   session[:nome_manutencao1]= 'EM ABERTO em '+((Date.today<<1).strftime("%B"))
   if (params[:estatisticas].to_i == 1)
      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id = 1 and situacao_manutencao_id = 1 and created_at > ? and created_at < ?", $datai, $dataf])
      session[:nome_manutencao]= 'ALVENARIA'
      render "estatisticasM"
   else if (params[:estatisticas].to_i == 2)
           @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 3 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
           session[:nome_manutencao]= 'DEDETIZAÇÂO'
           render "estatisticasM"
        else if (params[:estatisticas].to_i == 3)
              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 4 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
              session[:nome_manutencao]= 'ELETRODOMÉSTICOS'
              render "estatisticasM"
             else if (params[:estatisticas].to_i == 4)
                   @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 5 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                   session[:nome_manutencao]= 'ELÉTRICA'
                   render "estatisticasM"
                  else if (params[:estatisticas].to_i == 5)
                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 6 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                        session[:nome_manutencao]= 'MATERIAL DE COZINHA'
                        render "estatisticasM"
                       else if (params[:estatisticas].to_i == 6)
                             @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 7 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                             session[:nome_manutencao]= 'HIDRÁULICA'
                             render "estatisticasM"
                            else if (params[:estatisticas].to_i == 7)
                                  @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 9 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                                  session[:nome_manutencao]= 'MARCENARIA'
                                  render "estatisticasM"
                                  else if (params[:estatisticas].to_i == 8)
                                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 10 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                                        session[:nome_manutencao]= 'PINTURA'
                                        render "estatisticasM"
                                        else if (params[:estatisticas].to_i == 9)
                                              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 8 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                                              session[:nome_manutencao]= "LIMPEZA CAIXA D'AGUA"
                                              render "estatisticasM"
                                              else if (params[:estatisticas].to_i == 10)
                                                    @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 11 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                                                    session[:nome_manutencao]= "PLAYGROUND"
                                                    render "estatisticasM"
                                                    else if (params[:estatisticas].to_i == 11)
                                                          @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 13 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                                                          session[:nome_manutencao]= "SERRALHERIA"
                                                          render "estatisticasM"
                                                          else if (params[:estatisticas].to_i == 12)
                                                                @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 14 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                                                                session[:nome_manutencao]= "TELHADO"
                                                                render "estatisticasM"
                                                                else if (params[:estatisticas].to_i == 13)
                                                                      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 12 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                                                                      session[:nome_manutencao]= "PODA GRAMA"
                                                                      render "estatisticasM"
                                                                      else if (params[:estatisticas].to_i == 14)
                                                                            @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 15 and situacao_manutencao_id=1 and created_at > ? and created_at < ?", $datai, $dataf])
                                                                            session[:nome_manutencao]= "OUTROS SERVIÇOS"
                                                                            render "estatisticasM"
                                                                            else

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
        end
   end
  end


 def estatisticasMANTE
    session[:nome_manutencao1]= 'ENCERRADO em '+((Date.today<<1).strftime("%B"))
   if (params[:estatisticas].to_i == 1)
      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id=1 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
      session[:nome_manutencao]= 'ALVENARIA'
      render "estatisticasM"
   else if (params[:estatisticas].to_i == 2)
           @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 3 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
           session[:nome_manutencao]= 'DEDETIZAÇÂO'
           render "estatisticasM"
        else if (params[:estatisticas].to_i == 3)
              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 4 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
              session[:nome_manutencao]= 'ELETRODOMÉSTICOS'
              render "estatisticasM"
             else if (params[:estatisticas].to_i == 4)
                   @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 5 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                   session[:nome_manutencao]= 'ELÉTRICA'
                   render "estatisticasM"
                  else if (params[:estatisticas].to_i == 5)
                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 6 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                        session[:nome_manutencao]= 'MATERIAL DE COZINHA'
                        render "estatisticasM"
                       else if (params[:estatisticas].to_i == 6)
                             @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 7 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                             session[:nome_manutencao]= 'HIDRÁULICA'
                             render "estatisticasM"
                            else if (params[:estatisticas].to_i == 7)
                                  @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 9 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                                  session[:nome_manutencao]= 'MARCENARIA'
                                  render "estatisticasM"
                                  else if (params[:estatisticas].to_i == 8)
                                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 10 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                                        session[:nome_manutencao]= 'PINTURA'
                                        render "estatisticasM"
                                        else if (params[:estatisticas].to_i == 9)
                                              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 8 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                                              session[:nome_manutencao]= "LIMPEZA CAIXA D'AGUA"
                                              render "estatisticasM"
                                              else if (params[:estatisticas].to_i == 10)
                                                    @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 11 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                                                    session[:nome_manutencao]= "PLAYGROUND"
                                                    else if (params[:estatisticas].to_i == 11)
                                                          @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 13 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                                                          session[:nome_manutencao]= "SERRALHERIA"
                                                          render "estatisticasM"
                                                          else if (params[:estatisticas].to_i == 12)
                                                                @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 14 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                                                                session[:nome_manutencao]= "TELHADO"
                                                                render "estatisticasM"
                                                                else if (params[:estatisticas].to_i == 13)
                                                                      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 12 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                                                                      session[:nome_manutencao]= "PODA GRAMA"
                                                                      render "estatisticasM"
                                                                      else if (params[:estatisticas].to_i == 14)
                                                                            @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 15 and situacao_manutencao_id=2 and created_at > ? and created_at < ?", $datai, $dataf])
                                                                            session[:nome_manutencao]= "OUTROS SERVIÇOS"

                                                                            render "estatisticasM"
                                                                            else

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
        end
   end
 end


def estatisticasMANTAt
   session[:nome_manutencao1]= 'EM ATENDIMENTO em '+((Date.today<<1).strftime("%B"))
   if (params[:estatisticas].to_i == 1)
      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id=1 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
      session[:nome_manutencao]= 'ALVENARIA'
      render "estatisticasM"
   else if (params[:estatisticas].to_i == 2)
           @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 3 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
           session[:nome_manutencao]= 'DEDETIZAÇÂO'
           render "estatisticasM"
        else if (params[:estatisticas].to_i == 3)
              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 4 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
              session[:nome_manutencao]= 'ELETRODOMÉSTICOS'
              render "estatisticasM"
             else if (params[:estatisticas].to_i == 4)
                   @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 5 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                   session[:nome_manutencao]= 'ELÉTRICA'
                   render "estatisticasM"
                  else if (params[:estatisticas].to_i == 5)
                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 6 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                        session[:nome_manutencao]= 'MATERIAL DE COZINHA'
                        render "estatisticasM"
                       else if (params[:estatisticas].to_i == 6)
                             @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 7 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                             session[:nome_manutencao]= 'HIDRÁULICA'
                             render "estatisticasM"
                            else if (params[:estatisticas].to_i == 7)
                                  @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 9 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                                  session[:nome_manutencao]= 'MARCENARIA'
                                  render "estatisticasM"
                                  else if (params[:estatisticas].to_i == 8)
                                        @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 10 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                                        session[:nome_manutencao]= 'PINTURA'
                                        render "estatisticasM"
                                        else if (params[:estatisticas].to_i == 9)
                                              @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 8 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                                              session[:nome_manutencao]= "LIMPEZA CAIXA D'AGUA"
                                              render "estatisticasM"
                                              else if (params[:estatisticas].to_i == 10)
                                                    @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 11 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                                                    session[:nome_manutencao]= "PLAYGROUND"
                                                    render "estatisticasM"
                                                    else if (params[:estatisticas].to_i == 11)
                                                          @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 13 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                                                          session[:nome_manutencao]= "SERRALHERIA"
                                                          render "estatisticasM"
                                                          else if (params[:estatisticas].to_i == 12)
                                                                @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 14 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                                                                session[:nome_manutencao]= "TELHADO"
                                                                render "estatisticasM"
                                                                else if (params[:estatisticas].to_i == 13)
                                                                      @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 12 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                                                                      session[:nome_manutencao]= "PODA GRAMA"
                                                                      render "estatisticasM"
                                                                      else if (params[:estatisticas].to_i == 14)
                                                                            @mmanutencaos_estatisticas = Mmanutencao.all(:joins => 'INNER JOIN mmanutencaos_tipos_manutencaos ON mmanutencaos.id = mmanutencaos_tipos_manutencaos.mmanutencao_id', :conditions => ["mmanutencaos_tipos_manutencaos.tipos_manutencao_id= 15 and (situacao_manutencao_id=3 OR situacao_manutencao_id=4) and created_at > ? and created_at < ?", $datai, $dataf])
                                                                            session[:nome_manutencao]= "OUTROS SERVIÇOS"
                                                                            render "estatisticasM"
                                                                            else

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
        end
   end
 end


  def show
    @mmanutencao = Mmanutencao.find(params[:id])
    session[:idprotocolo]= @mmanutencao.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mmanutencao }
    end
  end

  def new
    @mmanutencao = Mmanutencao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mmanutencao }
    end
  end

  def edit
    @mmanutencao = Mmanutencao.find(params[:id])
  end

  def create
    @mmanutencao = Mmanutencao.new(params[:mmanutencao])


    @mmanutencao.data_sol= Time.now
    @mmanutencao.user_id = current_user.id
    respond_to do |format|
      if @mmanutencao.save
        flash[:notice] = 'MANUTENÇÂO SOLICITADA.'
        format.html { redirect_to(@mmanutencao) }
        format.xml  { render :xml => @mmanutencao, :status => :created, :location => @mmanutencao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mmanutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  def impressao_chamado_manutencao
      @mmanutencao = Mmanutencao.find(params[:id])
      sesssion[:idprotocolo] = @mmanutencao.id
    render :layout => "impressao"
  end


  def update
    @mmanutencao = Mmanutencao.find(params[:id])
   respond_to do |format|
      if @mmanutencao.update_attributes(params[:mmanutencao])
       if @mmanutencao.chefia_id == 12
          @mmanutencao.situacao = 'PARA ORÇAMENTO'
           if @mmanutencao.situacao_manutencao_id == 8
                 @mmanutencao.situacao = 'AUTORIZADO'
                @mmanutencao.chefia_id= 13
                @mmanutencao.data_autoriza = Time.now
           end
       else
         @mmanutencao.situacao = nil
       end
         
    
     @mmanutencao.save
        flash[:notice] = 'CADASTRADO COM SUCESSO.'
        format.html { redirect_to(@mmanutencao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mmanutencao.errors, :status => :unprocessable_entity }
      end
       t=0
    end
  end

  def destroy
    @mmanutencao = Mmanutencao.find(params[:id])
    @mmanutencao.destroy
    respond_to do |format|
      format.html { redirect_to(mmanutencaos_url) }
      format.xml  { head :ok }
    end
  end

def consulta
   render 'consultas'
  end

def lista_manutencao
    $chefia = params[:manutencao_chefia_id]
    @mmanutencaos   = Mmanutencao.find(:all, :conditions => ['chefia_id= ? and situacao_manutencao_id != 2', $chefia ])
    render :partial => 'lista_manutencao'
  end


def lista_unidade
    @mmanutencaos   = Mmanutencao.find(:all, :conditions => ['unidade_id= ? and situacao_manutencao_id != 2', params[:unidade_unidade_id] ])
    render :partial => 'lista_manutencao'
  end


  def despacho
    @mmanutencao = Mmanutencao.find(params[:id])
    @mmanutencao.data_ate = Time.now
  end

 def ordemservico
    @mmanutencao = Mmanutencao.find(params[:id])
 end

 def selected_print
   @mmanutencaos = Mmanutencao.find(params[:chamado_ids])
 end

 def impressao_manutencao
   @mmanutencao = Mmanutencao.find(params[:id])
   $idmanutencao= @mmanutencao.id

 end


 def protocolo
    @mmanutencao = Mmanutencao.find(params[:id])
    sesssion[:idprotocolo] = @mmanutencao.id
    @mmanutencao= Mmanutencao.find(sesssion[:idprotocolo])
   render :layout => "protocolo"
  end


 def imp_manutencao
    @mmanutencao= Mmanutencao.find(session[:idmanutencao])
   render :layout => "impressao"
  end

 def imp_show
    @mmanutencao= Mmanutencao.find(session[:idmanutencao])
   render :layout => "impressao"
  end

   def encerrados
    if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao') or current_user.has_role?('terceiro')or current_user.has_role?('oficios')
      #@mmanutencaos =Mmanutencao.all(:conditions =>["situacao_manutencao_id = 2" ], :order => 'data_enc DESC')
        @mmanutencaos = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id = 2")
    else
       @mmanutencaos = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id = 2 and unidade_id ="+(current_user.unidade_id).to_s+" order by data_enc DESC ")
      # @mmanutencaos =Mmanutencao.all(:conditions =>["situacao_manutencao_id = 2 and unidade_id = ?",current_user.unidade_id ], :order => 'data_enc DESC')
    end
   
  end

 def showencerrado
     @mmanutencao = Mmanutencao.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @mmanutencao }
    end
 end

 def busca_protocolo
$ok=1
    if (params[:search].present?)
      if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao')
        @mmanutencao = Mmanutencao.find(:all, :conditions => ["id = ?",  params[:search]])
        $ok=0
     else
        if current_user.has_role?('diretor_unidade')
           @mmanutencao = Mmanutencao.find(:all, :conditions => ["id = ? and unidade_id=?",  params[:search], current_user.unidade_id])
           $ok=0
        else
           @mmanutencao = Mmanutencao.find(:all, :conditions => ["id = ?",  params[:search]])
           $ok=0
       end
     end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mmanutencao }
    end
  end

end
