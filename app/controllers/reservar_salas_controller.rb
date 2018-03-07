class ReservarSalasController < ApplicationController

before_filter :load_salas
before_filter :load_servicos_salas
layout :define_layout
before_filter :login_required, :except => ["dowloads", "ata_ensino_fundamental_02_03_18", "ata_coordenadores_emei_02_03_18" ,"ata_infantil_01_03_18", "infantil_2018", "plano_educacao", "fudamental_2018", "banco_horas", "index", "show", "create", "new","edit","sel_dados", "confirma", "confirma_agenda"]

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

def impressao_calendar
  @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @reservar_salas = ReservarSala.all

  render :layout => "impressao_calendar"
  end



  def show
    @reservar_sala = ReservarSala.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reservar_sala }
    end
  end

  def new
    @reservar_sala = ReservarSala.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reservar_sala }
    end
  end

  def edit
    @reservar_sala = ReservarSala.find(params[:id])
  end

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
            flash[:notice] = 'RESERVADO COM SUCESSO.'
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

  def update
    @reservar_sala = ReservarSala.find(params[:id])
    respond_to do |format|
      if @reservar_sala.update_attributes(params[:reservar_sala])
        flash[:notice] = 'RESERVADO COM SUCESSO.'
        format.html { redirect_to(@reservar_sala) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reservar_sala.errors, :status => :unprocessable_entity }
      end
    end
  end

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
  end

 def sel_data
     session[:reservadata]= params[:reservar_sala_data_reserva]
 end


def dowloads
    
end

def infantil_2018
    #send_file("#{RAILS_ROOT}/public/documentos/Infantil_2018.pdf" , :type=>"pdf")
    send_file("#{RAILS_ROOT}/public/documentos/Infantil2018.xls" , :type=>"xls")
end

def fudamental_2018
    #send_file("#{RAILS_ROOT}/public/documentos/Fundamental_2018.pdf" , :type=>"pdf")
    send_file("#{RAILS_ROOT}/public/documentos/Fundamental2018.xls" , :type=>"xls")
end


def plano_educacao
    send_file("#{RAILS_ROOT}/public/documentos/plano_educacao.pdf" , :type=>"pdf")
end

def ata_infantil_01_03_18
    send_file("#{RAILS_ROOT}/public/documentos/ata_infantil_01_03_18.pdf" , :type=>"pdf")
end

def ata_coordenadores_emei_02_03_18
    send_file("#{RAILS_ROOT}/public/documentos/Coordenadores_EMEI_02_03_18.pdf" , :type=>"pdf")
end


def ata_ensino_fundamental_02_03_18
    send_file("#{RAILS_ROOT}/public/documentos/ensino_fundamental_02_03_18.pdf" , :type=>"pdf")
end



def banco_horas
    send_file("#{RAILS_ROOT}/public/documentos/banco_horas.pdf" , :type=>"pdf")
end

end
