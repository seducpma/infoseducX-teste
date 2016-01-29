class ReservarSalasController < ApplicationController
  # GET /reservar_salas
  # GET /reservar_salas.xml

before_filter :load_salas
before_filter :load_servicos_salas
layout :define_layout
before_filter :login_required, :except => ["index", "show", "create", "new","edit","sel_dados", "confirma", "confirma_agenda"]

 def load_servicos_salas
  @servicos_salas = ServicosSala.find(:all, :conditions=>['status = 1'] )
  end

 def load_salas
  @salas = Sala.find(:all, :order => "sala ASC" , :conditions=>['status = 1'])
  end

  def index
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @reservar_salas = ReservarSala.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reservar_salas }
    end
  end

  # GET /reservar_salas/1
  # GET /reservar_salas/1.xml
  def show
    @reservar_sala = ReservarSala.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reservar_sala }
    end
  end

  # GET /reservar_salas/new
  # GET /reservar_salas/new.xml
  def new
    @reservar_sala = ReservarSala.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reservar_sala }
    end
  end

  # GET /reservar_salas/1/edit
  def edit
    @reservar_sala = ReservarSala.find(params[:id])
  end

  # POST /reservar_salas
  # POST /reservar_salas.xml

def create

    @reservar_sala = ReservarSala.new(params[:reservar_sala])
    $salareserva = @reservar_sala.sala_id
    $datareserva = @reservar_sala.data_reserva
    $horareservai = (@reservar_sala.horario_reservai).to_time
    $horareservaf = (@reservar_sala.horario_reservaf).to_time
    @reservado =ReservarSala.find(:all, :conditions => ['sala_id = ? and data_reserva = ? and horario_reservai <= ? and horario_reservaf >= ?', $salareserva, $datareserva, $horareservai, $horareservai  ])
    if (@reservar_sala.horario_reservaf.hour < @reservar_sala.horario_reservai.hour)
      respond_to do |format|
       flash[:notice] = 'HORÁRIO DE ENCERRAMENTO MAIOR QUE HORÁRIO DE INICIO.'
       format.html { redirect_to new_reservar_sala_path }
       format.xml  { head :ok }
     end
   else
    if   (@reservar_sala.data_reserva >= (DateTime.now.to_date + 1))
     if ((@reservado.present? ))
     respond_to do |format|
       flash[:notice] = 'JÁ EXISTE RESERVA PARA ESTE DIA E HORA.'
       format.html { redirect_to reservar_salas_path }
       format.xml  { head :ok }
     end
    else
     respond_to do |format|
          if @reservar_sala.save
            flash[:notice] = 'Cadastrado com sucesso.'
            format.html { redirect_to(@reservar_sala) }
            format.xml  { render :xml => @reservar_sala, :status => :created, :location => @reservar_sala }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @reservar_sala.errors, :status => :unprocessable_entity }
          end
        end
    end
    else
       respond_to do |format|
       flash[:notice] = 'RESERVA DEVE SER FEITA COM 24 HORAS DE ANTECEDÊNCIA.'
       format.html { redirect_to reservar_salas_path }
       format.xml  { head :ok }
     end
    end
  end
 end

  
  # PUT /reservar_salas/1
  # PUT /reservar_salas/1.xml
  def update
    @reservar_sala = ReservarSala.find(params[:id])

    respond_to do |format|
      if @reservar_sala.update_attributes(params[:reservar_sala])
        flash[:notice] = 'Cadastrado com sucesso.'
        format.html { redirect_to(@reservar_sala) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reservar_sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reservar_salas/1
  # DELETE /reservar_salas/1.xml
  def destroy
    @reservar_sala = ReservarSala.find(params[:id])
    @reservar_sala.destroy

    respond_to do |format|
      format.html { redirect_to(reservar_salas_url) }
      format.xml  { head :ok }
    end
  end


  def define_layout
    if logged_in?
      'application'
    else
      'inscricao'
    end
  end


def confirma_agenda

end
 def sel_dados
    @dados = Sala.find(params[:reservar_sala_sala_id])
    session[:reservasala]= params[:reservar_sala_sala_id]
    render :partial => 'exibe_dados'
    #render :update do |page|
    #  page.replace_html "especifica", :partial => 'exibe_dados'
    #end
  end

 def sel_data
     session[:reservadata]= params[:reservar_sala_data_reserva]
 end



end
