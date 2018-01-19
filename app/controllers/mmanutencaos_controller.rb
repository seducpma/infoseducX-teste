class MmanutencaosController < ApplicationController
 before_filter :load_tipomanutencaos
 before_filter :load_unidades
 before_filter :load_funcionarios
 before_filter :load_situacaos
 before_filter :load_chefias


 def load_funcionarios
    # session[:base]= 'sisgered_development'
   #session[:base]= 'sisgered_production'
   if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao')
      @funcionarios = Funcionario.find(:all,:conditions => ['desligado=?',0], :order => 'nome ASC' )
   else
       @funcionarios = Funcionario.find(:all, :conditions => ['desligado=?',0], :order => 'nome ASC' )
   end
      if current_user.unidade_id == 52 or current_user.unidade_id == 53
           @protocolos = Mmanutencao.find(:all, :conditions =>['situacao_manutencao_id != 2'], :order => 'id ASC')
      else
          @protocolos = Mmanutencao.find(:all, :conditions =>['unidade_id =? AND situacao_manutencao_id != 2', current_user.unidade_id], :order => 'id ASC')
      end
 end

  def load_chefias
    @chefias1 = Chefia.find(:all,  :conditions => ['desligado=? ',0], :order => 'nome ASC')
  end

  def load_situacaos
    @situacaos = SituacaoManutencao.find(:all)
  end


  def load_tipomanutencaos
       @tipos_manutencaos =  TiposManutencao.find(:all)
   end

   def load_unidades
   if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao')
       @unidades_manutencao =  Unidade.find(:all, :order => 'nome ASC')
      else
        if (current_user.unidade_id== 53)
           @unidades_manutencao =  Unidade.find(:all, :order => 'nome ASC')
        else
          @unidades_manutencao =  Unidade.find(:all, :conditions => ['id = ?',current_user.unidade_id ],:order => 'nome ASC')
        end
    end
     @unidades =  Unidade.find(:all, :order => 'nome ASC')
   end

 def index
    if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao') 
        @mmanutencaos_abertas = Mmanutencao.all(:conditions => ["situacao_manutencao_id <> 2"])
        @mmanutencaos_unidade = Mmanutencao.find_by_sql("SELECT uni.nome AS nome, mma.id, mma.unidade_id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <>2")
    else
      if current_user.has_role?('diretor_unidade')
       @mmanutencaos = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <> 2")
        @mmanutencaos_abertas = Mmanutencao.all(:conditions => ["situacao_manutencao_id <> 2"])
       @mmanutencaos_unidade = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <> 2 and mma.unidade_id ="+(current_user.unidade_id).to_s+"")
      else
       @mmanutencaos_abertas = Mmanutencao.all(:conditions => ["situacao_manutencao_id <> 2"])
       @mmanutencaos_unidade = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id <> 2 and mma.unidade_id ="+(current_user.unidade_id).to_s+"")
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
        flash[:notice] = 'CADASTRADO COM SUCESSO.'
        format.html { redirect_to(@mmanutencao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mmanutencao.errors, :status => :unprocessable_entity }
      end
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


   def encerrados
    if current_user.has_role?('admin') or current_user.has_role?('admin_manutencao')
      #@mmanutencaos =Mmanutencao.all(:conditions =>["situacao_manutencao_id = 2" ], :order => 'data_enc DESC')
        @mmanutencaos = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id = 2")
    else
       @mmanutencaos = Mmanutencao.find_by_sql("SELECT uni.nome as nome, mma.id, mma.unidade_id, mma.situacao_manutencao_id, mma.funcionario_id, mma.ffuncionario, mma.chefia_id, mma.user_id, mma.descricao, mma.data_sol, mma.data_ate, mma.data_enc, mma.forma, mma.solicitante, mma.procedimentos, mma.executado, mma.justificativa, mma.obs  FROM mmanutencaos mma INNER JOIN "+session[:base]+".unidades uni ON uni.id = mma.unidade_id WHERE situacao_manutencao_id = 2 and unidade_id ="+current_user.unidade_id+" order by data_enc DESC ")
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
