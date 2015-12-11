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
   if current_user.unidade_id== 53 
       @unidades = Unidade.find(:all,:conditions => ["id < 11"], :order => 'nome ASC')
       @unidadest = Unidade.find(:all, :order => "nome ASC")
  else
       @unidades = Unidade.find(:all, :conditions =>  ["id < 11 and id=?", current_user.unidade_id], :order => 'nome ASC')
       @unidadest = Unidade.find(:all, :order => "nome ASC")
    end
  end



def load_estagiarios
   if (current_user.unidade_id== 53)
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
 t=0
  end

  # GET /itinerarios/1
  # GET /itinerarios/1.xml
  def show
    @agenda = Agenda.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  # GET agenda/new
  # GET /agenda/new.xml
  def new
    @agenda = Agenda.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  # GET /itinerarios/1/edit
  def edit
    @agenda = Agenda.find(params[:id])
  end

  # POST /itinerarios
  # POST /itinerarios.xml
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

  # PUT /agenda/1
  # PUT /agenda/1.xml
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

  # DELETE /agenda/1
  # DELETE /agenda/1.xml
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
