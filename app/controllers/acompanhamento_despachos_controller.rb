class AcompanhamentoDespachosController < ApplicationController
  # GET /acompanhamento_despachos
  # GET /acompanhamento_despachos.xml
  def index
    @acompanhamento_despachos = AcompanhamentoDespacho.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @acompanhamento_despachos }
    end
  end

  # GET /acompanhamento_despachos/1
  # GET /acompanhamento_despachos/1.xml
  def show
    @acompanhamento_despacho = AcompanhamentoDespacho.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @acompanhamento_despacho }
    end
  end

  # GET /acompanhamento_despachos/new
  # GET /acompanhamento_despachos/new.xml
  def new
    @acompanhamento_despacho = AcompanhamentoDespacho.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @acompanhamento_despacho }
    end
  end

  # GET /acompanhamento_despachos/1/edit
  def edit
    @acompanhamento_despacho = AcompanhamentoDespacho.find(params[:id])
  end

  # POST /acompanhamento_despachos
  # POST /acompanhamento_despachos.xml
  def create
    @acompanhamento_despacho = AcompanhamentoDespacho.new(params[:acompanhamento_despacho])

    respond_to do |format|
      if @acompanhamento_despacho.save
        flash[:notice] = 'AcompanhamentoDespacho was successfully created.'
        format.html { redirect_to(@acompanhamento_despacho) }
        format.xml  { render :xml => @acompanhamento_despacho, :status => :created, :location => @acompanhamento_despacho }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @acompanhamento_despacho.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /acompanhamento_despachos/1
  # PUT /acompanhamento_despachos/1.xml
  def update
    @acompanhamento_despacho = AcompanhamentoDespacho.find(params[:id])

    respond_to do |format|
      if @acompanhamento_despacho.update_attributes(params[:acompanhamento_despacho])
        flash[:notice] = 'AcompanhamentoDespacho was successfully updated.'
        format.html { redirect_to(@acompanhamento_despacho) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @acompanhamento_despacho.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /acompanhamento_despachos/1
  # DELETE /acompanhamento_despachos/1.xml
  def destroy
    @acompanhamento_despacho = AcompanhamentoDespacho.find(params[:id])
    @acompanhamento_despacho.destroy

    respond_to do |format|
      format.html { redirect_to(acompanhamento_despachos_url) }
      format.xml  { head :ok }
    end
  end
end
