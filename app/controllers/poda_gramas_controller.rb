class PodaGramasController < ApplicationController

    before_filter :load_iniciais


 def agendamento
          @date = params[:month] ? Date.parse(params[:month]) : Date.today
          @poda_grama = PodaGrama.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @poda_grama }
    end
  end


 def agenda_execucao
          @date = params[:month] ? Date.parse(params[:month]) : Date.today
          @poda_grama = PodaGrama.find(:all, :conditions=> ["agendamento is not null"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @poda_grama }
    end
  end

  def agenda_executada
          @date = params[:month] ? Date.parse(params[:month]) : Date.today
          @poda_grama = PodaGrama.find(:all, :conditions=> ["execucao is not null"])
           session[:titulo_agenda]=' AGENDA DE PODAS DE GRAMA EXECUTADAS- SEDUC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @poda_grama }
    end
  end

    def agenda_nexecutada
          @date = params[:month] ? Date.parse(params[:month]) : Date.today
          @poda_grama = PodaGrama.find(:all, :conditions=> ["execucao is null"])
           session[:titulo_agenda]=' AGENDA DE PODAS DE GRAMA NÃO EXECUTADAS- SEDUC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @poda_grama }
    end
  end


  # GET /poda_gramas/new
  # GET /poda_gramas/new.xml
  def new
    @poda_grama = PodaGrama.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @poda_grama }
    end
  end

  def show
    @poda_grama = PodaGrama.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @poda_grama }
    end
  end

  # GET /poda_gramas/1/edit
  def edit
    @poda_grama = PodaGrama.find(params[:id])
    session[:agendamento]=@poda_grama.agendamento


  end

  # POST /poda_gramas
  # POST /poda_gramas.xml
  def create
    @poda_grama = PodaGrama.new(params[:poda_grama])

    respond_to do |format|
      if @poda_grama.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@poda_grama) }
        format.xml  { render :xml => @poda_grama, :status => :created, :location => @poda_grama }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @poda_grama.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /poda_gramas/1
  # PUT /poda_gramas/1.xml
  def update
    @poda_grama = PodaGrama.find(params[:id])
    @poda_grama.execucao

    if !@poda_grama.execucao.nil?
          @poda_grama.agendamento = session[:agendamento]
    end
    respond_to do |format|
      if @poda_grama.update_attributes(params[:poda_grama])
          if !@poda_grama.execucao.nil?
             @poda_grama.agendamento = session[:agendamento]
          end
         @poda_grama.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@poda_grama) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @poda_grama.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /poda_gramas/1
  # DELETE /poda_gramas/1.xml
  def destroy
    @poda_grama = PodaGrama.find(params[:id])
    @poda_grama.destroy

    respond_to do |format|
      format.html { redirect_to(poda_gramas_url) }
      format.xml  { head :ok }
    end
  end

  def load_iniciais
        if current_user.has_role?('admin') or current_user.has_role?('SEDUC')or current_user.has_role?('terceiro')
            @unidades = Unidade.find(:all,  :select => 'nome, id', :order => 'nome ASC')
        else
            @unidades= Unidade.find(:all,  :select => 'nome, id', :conditions =>  ["id=?", current_user.unidade_id], :order => 'nome ASC')
        end
    end

    def impressao_agendamento
            @agendamento = PodaGrama.find(:all, :conditions =>  ["data between ? and ?  AND ano_letivo=? AND unidade_id=?", session[:dataI].to_s, session[:dataF].to_s, Time.now.year, session[:aulas_falta_unidade_id]], :order => 'data ASC')
        render :layout => "impressao"
    end



    def impressao_calendar_agendamento
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
      @agendamento = PodaGrama.all
      render :layout => "impressao_calendar"
  end

  def impressao_calendar_agenda
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
      @agendamento = PodaGrama.find(:all, :conditions=> ["agendamento is not null"])
      render :layout => "impressao_calendar"
  end

  def impressao_calendar_execucoes
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
      @agendamento = PodaGrama.find(:all, :conditions=> ["execucao is not null"])
      render :layout => "impressao_calendar"
  end

    def impressao_calendar_nexecutado
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
      @agendamento = PodaGrama.find(:all, :conditions=> ["execucao is null"])

      render :layout => "impressao_calendar"
  end



 def  relatorios_agendamento

        session[:dia_final]=params[:diaF]
        session[:mesF]=params[:mesF]
        session[:dataI]=params[:poda_grama][:dataI][6,4]+'-'+params[:poda_grama][:dataI][3,2]+'-'+params[:poda_grama][:dataI][0,2]
        session[:dataF]=params[:poda_grama][:dataF][6,4]+'-'+params[:poda_grama][:dataF][3,2]+'-'+params[:poda_grama][:dataF][0,2]
        session[:mes]=params[:poda_grama][:dataF][3,2]

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

       if params[:type_of].to_i == 1
            @agendamento = PodaGrama.find(:all, :conditions =>  ["created_at between ? and ? ", session[:dataI].to_s, session[:dataF].to_s ], :order => 'agendamento ASC')
       else if params[:type_of].to_i == 2
                 @agendamento = PodaGrama.find(:all, :conditions =>  ["agendamento between ? and ? ", session[:dataI].to_s, session[:dataF].to_s ], :order => 'agendamento ASC')
            else if params[:type_of].to_i == 3
                     @agendamento = PodaGrama.find(:all, :conditions =>  ["execucao between ? and ? ", session[:dataI].to_s, session[:dataF].to_s ], :order => 'agendamento ASC')
                 else if params[:type_of].to_i == 4
                           @agendamento = PodaGrama.find(:all, :conditions =>  ["(agendamento between ? and ?) and execucao is null", session[:dataI].to_s, session[:dataF].to_s ], :order => 'agendamento ASC')
                       end
                 end
           end
       end
        render :update do |page|
            page.replace_html 'calendario', :partial => 'relatorios_agendamento'
        end


 end


 def agenda_poda_grama
     t=0
       if params[:type_of].to_i == 1
          @date = params[:month] ? Date.parse(params[:month]) : Date.today
          @poda_grama = PodaGrama.all
          session[:titulo_agenda]='AGENDA SOLICITAÇÂO DE EXECUÇÃO DE PODA DE GRAMA - SEDUC '
        render :update do |page|
            page.replace_html 'calendario', :partial => 'agendamento'
        end
            #render :partial => "agenda"
       else if params[:type_of].to_i == 2
              @date = params[:month] ? Date.parse(params[:month]) : Date.today
              @poda_grama = PodaGrama.find(:all, :conditions=> ["agendamento is not null"])
              session[:titulo_agenda]='AGENDA DE EXECUÇÃO DE PODA DE GRAMA - SEDUC '
              render :update do |page|
                 page.replace_html 'calendario', :partial => 'agenda'
              end
            else if params[:type_of].to_i == 3
                    @date = params[:month] ? Date.parse(params[:month]) : Date.today
                    @poda_grama = PodaGrama.find(:all, :conditions=> ["execucao is not null"])
                     session[:titulo_agenda]=' AGENDA DE PODAS DE GRAMA EXECUTADAS- SEDUC'
                    render :update do |page|
                       page.replace_html 'calendario', :partial => 'agenda'
                    end
                 else if params[:type_of].to_i == 4
                        @date = params[:month] ? Date.parse(params[:month]) : Date.today
                        @poda_grama = PodaGrama.find(:all, :conditions=> ["execucao is null"])
                         session[:titulo_agenda]=' PODAS DE GRAMA AGENDAS MAS NÃO EXECUTADAS- SEDUC'
                        render :update do |page|
                           page.replace_html 'calendario', :partial => 'agenda'
                        end
                     end
                 end
            end
       end

 end


end
