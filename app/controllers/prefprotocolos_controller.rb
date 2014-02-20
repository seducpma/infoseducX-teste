class PrefprotocolosController < ApplicationController
  # GET /prefprotocolos
  # GET /prefprotocolos.xml
  def index
    @prefprotocolos = Prefprotocolo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prefprotocolos }
    end
  end

  # GET /prefprotocolos/1
  # GET /prefprotocolos/1.xml
  def show
    @prefprotocolo = Prefprotocolo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prefprotocolo }
    end
  end

  # GET /prefprotocolos/new
  # GET /prefprotocolos/new.xml
  def new
    @prefprotocolo = Prefprotocolo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prefprotocolo }
    end
  end

  # GET /prefprotocolos/1/edit
  def edit
    @prefprotocolo = Prefprotocolo.find(params[:id])
  end

  # POST /prefprotocolos
  # POST /prefprotocolos.xml
  def create
    @prefprotocolo = Prefprotocolo.new(params[:prefprotocolo])

    respond_to do |format|
      if @prefprotocolo.save
        flash[:notice] = 'Prefprotocolo was successfully created.'
        format.html { redirect_to(@prefprotocolo) }
        format.xml  { render :xml => @prefprotocolo, :status => :created, :location => @prefprotocolo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prefprotocolo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prefprotocolos/1
  # PUT /prefprotocolos/1.xml
  def update
    @prefprotocolo = Prefprotocolo.find(params[:id])

    respond_to do |format|
      if @prefprotocolo.update_attributes(params[:prefprotocolo])
        flash[:notice] = 'Prefprotocolo was successfully updated.'
        format.html { redirect_to(@prefprotocolo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prefprotocolo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prefprotocolos/1
  # DELETE /prefprotocolos/1.xml
  def destroy
    @prefprotocolo = Prefprotocolo.find(params[:id])
    @prefprotocolo.destroy

    respond_to do |format|
      format.html { redirect_to(prefprotocolos_url) }
      format.xml  { head :ok }
    end
  end
end
