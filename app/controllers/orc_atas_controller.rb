class OrcAtasController < ApplicationController
  # GET /orc_atas
  # GET /orc_atas.xml
  def index
    @orc_atas = OrcAta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_atas }
    end
  end

  # GET /orc_atas/1
  # GET /orc_atas/1.xml
  def show
    @orc_ata = OrcAta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_ata }
    end
  end

  # GET /orc_atas/new
  # GET /orc_atas/new.xml
  def new
    @orc_ata = OrcAta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_ata }
    end
  end

  # GET /orc_atas/1/edit
  def edit
    @orc_ata = OrcAta.find(params[:id])
  end

  # POST /orc_atas
  # POST /orc_atas.xml
  def create
    @orc_ata = OrcAta.new(params[:orc_ata])
    @orc_ata.id
    @ata = OrcAta.find(:all, :conditions =>['id=?',@orc_ata.id])
    respond_to do |format|
      if @orc_ata.save
        flash[:notice] = 'OrcAta was successfully created.'
        format.html { redirect_to( {:action => "edit", :id =>@ata[0].id} ) }
        format.xml  { render :xml => @orc_ata, :status => :created, :location => @orc_ata }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_ata.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_atas/1
  # PUT /orc_atas/1.xml
  def update
    @orc_ata = OrcAta.find(params[:id])

    respond_to do |format|
      if @orc_ata.update_attributes(params[:orc_ata])
        flash[:notice] = 'OrcAta was successfully updated.'
        format.html { redirect_to(@orc_ata) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_ata.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_atas/1
  # DELETE /orc_atas/1.xml
  def destroy
    @orc_ata = OrcAta.find(params[:id])
    @orc_ata.destroy

    respond_to do |format|
      format.html { redirect_to(orc_atas_url) }
      format.xml  { head :ok }
    end
  end
end
