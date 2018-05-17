class UnidadesController < ApplicationController
   before_filter :load_unidades
   before_filter :load_tipos

def load_tipos
      @tipos = Tipo.find(:all, :order => 'nome ASC')
end

  def load_unidades
      @unidades = Unidade.find(:all, :order => 'nome ASC')
      @professor= Professor.find(:all, :conditions => ['unidade_id=?', current_user.unidade_id])
      @estagios =TiposEstagio.find(:all, :select => 'nome',:order => 'nome ASC')
  end

  def index
    @unidades = Unidade.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @unidades }
    end
  end

  def show
    @unidade = Unidade.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @unidade }
    end
  end

  def new
    @unidade = Unidade.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @unidade }
    end
  end

  def edit
    @unidade = Unidade.find(params[:id])
  end

  def create
    @unidade = Unidade.new(params[:unidade])
    respond_to do |format|
      if @unidade.save
        flash[:notice] = 'SALVO COM SUCESSO!'
        format.html { redirect_to(@unidade) }
        format.xml  { render :xml => @unidade, :status => :created, :location => @unidade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @unidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @unidade = Unidade.find(params[:id])
    respond_to do |format|
      if @unidade.update_attributes(params[:unidade])
        flash[:notice] = 'SALVO COM SUCESSO!'
        format.html { redirect_to(@unidade) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @unidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @unidade = Unidade.find(params[:id])
    @unidade.destroy
    respond_to do |format|
      format.html { redirect_to(unidades_url) }
      format.xml  { head :ok }
    end
  end

 def consulta_unidade
   if params[:type_of].to_i == 1

   else if params[:type_of].to_i == 2
            @unidades = Unidade.find(:all, :conditions => ["endereco like ?", "%" + params[:search1].to_s + "%"],:order => 'nome ASC')
           render :update do |page|
                page.replace_html 'unidades', :partial => "unidades"
              end
         else if params[:type_of].to_i == 3
              end
          end
  end
end

 def lista_unidade_nome
    @unidades = Unidade.find(:all, :conditions => ['id=?', params[:unidade_unidade_id]])
    render :partial => 'unidades'
  end

 def lista_tipo
   @unidades = Unidade.find(:all, :conditions => ['tipo_id=?', params[:unidade_tipo_id]])
   render :partial => 'unidades'
  end

 def sem_estagiarios
     if params[:type_of].to_i == 1
         session[:type_of] = 1
          session[:unidade_id] = params[:unidade][:id]
          @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_trab as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 0 and unidades.id=?", params[:unidade][:id]],:order => 'unidades.nome ASC')
             render :update do |page|
                 page.replace_html 'estagiarios_unidade', :partial => "estagiarios_unidade"
             end
     else if params[:type_of].to_i == 2
             session[:type_of] = 2
             session[:estagiario_tipo] =  params[:estagiario][:tipo]
             @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_trab as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 0  and estagiarios.tipo=?  and estagiarios.periodo_trab  is not null", params[:estagiario][:tipo] ],:order => 'unidades.nome ASC')
                 render :update do |page|
                     page.replace_html 'estagiarios_unidade', :partial => "estagiarios_unidade"
                 end
          else if params[:type_of].to_i == 3
                  session[:type_of] = 3
                  session[:periodo_est] = params[:periodo_est]
                   @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_trab as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 0  and estagiarios.periodo_est=?", params[:periodo_est]],:order => 'unidades.nome ASC')
                     render :update do |page|
                         page.replace_html 'estagiarios_unidade', :partial => "estagiarios_unidade"
                     end
              else if params[:type_of].to_i == 4
                      session[:type_of] = 4
                     @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_trab as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 0 and estagiarios.flag=0"],:order => 'unidades.nome ASC')
                         render :update do |page|
                             page.replace_html 'estagiarios_unidade', :partial => "estagiarios_unidade"
                         end
                     else if params[:type_of].to_i == 5
                             session[:type_of] = 5
                         @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_trab as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 1 and estagiarios.flag=0"],:order => 'unidades.nome ASC')
                             render :update do |page|
                                 page.replace_html 'estagiarios_unidade', :partial => "estagiarios_unidade"
                             end
                     end
                  end
              end
          end
     end

  end


  def impressao_estagiarios_unidade
     if session[:type_of]== 1
          @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_est as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 0 and unidades.id=?", session[:unidade_id]],:order => 'unidades.nome ASC')
             render  :layout => "impressao"
     else if session[:type_of] == 2
             @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_est as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 0  and estagiarios.tipo=?", session[:estagiario_tipo] ],:order => 'unidades.nome ASC')
                 render  :layout => "impressao"
          else if session[:type_of] == 3
                   @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_est as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 0  and estagiarios.periodo_est=?", session[:periodo_est]],:order => 'unidades.nome ASC')
                     render  :layout => "impressao"
              else if session[:type_of] == 4
                     @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_est as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 0 and estagiarios.flag=0"],:order => 'unidades.nome ASC')
                         render :layout => "impressao"
                     else if session[:type_of] == 5
                         @unidade_estagiario =Unidade.find(:all, :select => 'unidades.nome as unidade, estagiarios.nome as nomeest, estagiarios.periodo_est as periodoest, estagiarios.tipo as tipoest', :joins => "INNER JOIN "+session[:baseinfo]+".estagiarios  ON unidades.id = estagiarios.unidade_id", :conditions => ["estagiarios.desligado = 1 and estagiarios.flag=0"],:order => 'unidades.nome ASC')
                             render  :layout => "impressao"
                             end
                     end
                  end
              end
          end
     end

end


