class AgendasController < ApplicationController
  # GET /itinerarios
  # GET /itinerarios.xml

  before_filter :load_estagiarios
  before_filter :load_unidades
  before_filter :load_agenda
  layout :define_layout
  before_filter :login_required, :except => ["index"]

  def load_agenda
    @agenda1 = Agenda.find(:all)
    
  end
def load_unidades
   if current_user.unidade_id== 53 or current_user.unidade_id== 52
       @unidades_fudamental = Unidade.find(:all, :conditions => ["tipo_id = 1 or  tipo_id = 4 or tipo_id = 7"], :order => "nome ASC" )
       @unidadest = Unidade.find(:all, :order => "nome ASC")
  else
       @unidades_fudamental = Unidade.find(:all, :conditions => ["(tipo_id = 1 or  tipo_id = 4 or tipo_id = 7) and id=?", current_user.unidade_id], :order => 'nome ASC')
       @unidadest = Unidade.find(:all, :order => "nome ASC")
    end
  end



def load_estagiarios
   if (current_user.unidade_id== 53 or current_user.unidade_id== 52)
       @estagiarios = Estagiario.find(:all, :conditions =>  ["desligado=0"], :order => 'nome ASC')
    else
       @estagiarios = Estagiario.find(:all, :conditions =>  ["desligado=0 and unidade_id=?", current_user.unidade_id], :order => 'nome ASC')

    end
  end


  def index
   define_layout
   @date = params[:month] ? Date.parse(params[:month]) : Date.today
   @search = Agenda.search(params[:search])
   if (params[:search].blank?)
   else
      @agenda = @search.all
   end

  end

  def show
    @agenda = Agenda.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  def new
    @agenda = Agenda.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  def edit
    @agenda = Agenda.find(params[:id])
  end

  def create
    @agenda = Agenda.new(params[:agenda])
    respond_to do |format|
      if @agenda.save
        flash[:notice] = 'AGENDAMENTO SALVO COM SUCESSO.'
        format.html { redirect_to(@agenda) }
        format.xml  { render :xml => @agenda, :status => :created, :location => @agenda }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @agenda = Agenda.find(params[:id])
    respond_to do |format|
      if @agenda.update_attributes(params[:agenda])
        flash[:notice] = 'AGENDAMENTO SALVO COM SUCESSO.'
        format.html { redirect_to(@agenda) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @agenda = Agenda.find(params[:id])
    @agenda.destroy
    respond_to do |format|
      format.html { redirect_to(agendas_url) }
      format.xml  { head :ok }
    end
  end

   def define_layout
    if logged_in?
      'application'
    else
      'login'
    end
  end
end
