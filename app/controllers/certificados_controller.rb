class CertificadosController < ApplicationController
  # GET /certificados
  # GET /certificados.xml
  #before_filter :login_required, :except => ["aviso", "index", "show", "create", "new","edit","sel_dados", "confirma", "confirma_agenda"]
  layout :define
   before_filter :load_iniciais


  def load_iniciais

            @cursos = Curso.find(:all, :order => 'nome ASC')

    end


  def index
    @certificados = Certificado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @certificados }
    end
  end

def aviso
  
end

  def define
    if logged_in?
      'application'
    else
      'inscricao'
    end
  end

  # GET /certificados/1
  # GET /certificados/1.xml
  def show
    @certificado = Certificado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @certificado }
    end
  end

  # GET /certificados/new
  # GET /certificados/new.xml
  def new
    @certificado = Certificado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @certificado }
    end
  end

  # GET /certificados/1/edit
  def edit
    @certificado = Certificado.find(params[:id])
  end

  # POST /certificados
  # POST /certificados.xml
  def create
    @certificado = Certificado.new(params[:certificado])

    respond_to do |format|
      if @certificado.save
        flash[:notice] = 'Certificado was successfully created.'
        format.html { redirect_to(@certificado) }
        format.xml  { render :xml => @certificado, :status => :created, :location => @certificado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @certificado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /certificados/1
  # PUT /certificados/1.xml
  def update
    @certificado = Certificado.find(params[:id])

    respond_to do |format|
      if @certificado.update_attributes(params[:certificado])
        flash[:notice] = 'Certificado was successfully updated.'
        format.html { redirect_to(@certificado) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @certificado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /certificados/1
  # DELETE /certificados/1.xml
  def destroy
    @certificado = Certificado.find(params[:id])
    @certificado.destroy

    respond_to do |format|
      format.html { redirect_to(certificados_url) }
      format.xml  { head :ok }
    end
  end
end
