class MmanutencaosController < ApplicationController
  # GET /mmanutencaos
  # GET /mmanutencaos.xml
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




  def index
    if current_user.has_role?('administrador') or current_user.has_role?('admin_manutencao')
       @mmanutencaos = Mmanutencao.all(:conditions =>  "situacao_manutencao_id <> 2")
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

 def estatistica
    
    if current_user.has_role?('administrador') or current_user.has_role?('admin_manutencao')
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
                                                    render "estatisticasM"
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



# GET /mmanutencaos/1
  # GET /mmanutencaos/1.xml
  def show
    @mmanutencao = Mmanutencao.find(params[:id])
    $idprotocolo = @mmanutencao.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mmanutencao }
    end
  end

  # GET /mmanutencaos/new
  # GET /mmanutencaos/new.xml
  def new
    @mmanutencao = Mmanutencao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mmanutencao }
    end
  end

  # GET /mmanutencaos/1/edit
  def edit
    @mmanutencao = Mmanutencao.find(params[:id])
  end

  # POST /mmanutencaos
  # POST /mmanutencaos.xml
  def create
    @mmanutencao = Mmanutencao.new(params[:mmanutencao])
    @mmanutencao.data_sol= Time.now
    @mmanutencao.user_id = current_user.id
    
    respond_to do |format|
      if @mmanutencao.save
        flash[:notice] = 'Manutencao solicitada.'
        MmanutencaoMailer.deliver_notificar_mmanutencao(@mmanutencao)
        format.html { redirect_to(@mmanutencao) }
        format.xml  { render :xml => @mmanutencao, :status => :created, :location => @mmanutencao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mmanutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mmanutencaos/1
  # PUT /mmanutencaos/1.xml
  def update
    @mmanutencao = Mmanutencao.find(params[:id])
    
    respond_to do |format|
      if @mmanutencao.update_attributes(params[:mmanutencao])
        flash[:notice] = 'Cadastrado com sucesso.'
        format.html { redirect_to(@mmanutencao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mmanutencao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mmanutencaos/1
  # DELETE /mmanutencaos/1.xml
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


  def despacho
    @mmanutencao = Mmanutencao.find(params[:id])
    @mmanutencao.data_ate = Time.now
  end

 def ordemservico
    @mmanutencao = Mmanutencao.find(params[:id])
    #@funcionarios = Funcionario.find(:all, :joins =>:chefia, :conditions => ['desligado=? and chefia.user_id',0, current_user], :order => 'nome ASC' )
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
    $idprotocolo = @mmanutencao.id
    t= $idprotocolo
    @mmanutencao= Mmanutencao.find(t)
   render :layout => "protocolo"
  end


 def imp_manutencao
   t= $idmanutencao
    @mmanutencao= Mmanutencao.find(t)
   render :layout => "protocolo"
  end


   def encerrados
    @mmanutencaos =Mmanutencao.all(:conditions =>["situacao_manutencao_id = 2 and unidade_id = ?",current_user.unidade_id ], :order => 'data_enc DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mmanutencaos }
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
      if current_user.has_role?('administrador') or current_user.has_role?('admin_manutencao')
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
