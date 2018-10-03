class OrcAtaItensController < ApplicationController
  # GET /orc_ata_itens
  # GET /orc_ata_itens.xml
  def index
    @orc_ata_itens = OrcAtaIten.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_ata_itens }
    end
  end

  # GET /orc_ata_itens/1
  # GET /orc_ata_itens/1.xml
  def show
    @orc_ata_iten = OrcAtaIten.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_ata_iten }
    end
  end

  # GET /orc_ata_itens/new
  # GET /orc_ata_itens/new.xml
  def new
    @orc_ata_iten = OrcAtaIten.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_ata_iten }
    end
  end

  # GET /orc_ata_itens/1/edit
  def edit
    @orc_ata_iten = OrcAtaIten.find(params[:id])
  end

  # POST /orc_ata_itens
  # POST /orc_ata_itens.xml
  def create
    @orc_ata_iten = OrcAtaIten.new(params[:orc_ata_iten])

    respond_to do |format|
      if @orc_ata_iten.save
        flash[:notice] = 'OrcAtaIten was successfully created.'
        format.html { redirect_to(@orc_ata_iten) }
        format.xml  { render :xml => @orc_ata_iten, :status => :created, :location => @orc_ata_iten }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_ata_iten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_ata_itens/1
  # PUT /orc_ata_itens/1.xml
  def update
    @orc_ata_iten = OrcAtaIten.find(params[:id])

    respond_to do |format|
      if @orc_ata_iten.update_attributes(params[:orc_ata_iten])
        flash[:notice] = 'OrcAtaIten was successfully updated.'
        format.html { redirect_to(@orc_ata_iten) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_ata_iten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_ata_itens/1
  # DELETE /orc_ata_itens/1.xml
  def destroy
    @orc_ata_iten = OrcAtaIten.find(params[:id])
    @orc_ata_iten.destroy

    respond_to do |format|
      format.html { redirect_to(orc_ata_itens_url) }
      format.xml  { head :ok }
    end
  end
end
