class OrcNotaFiscalsController < ApplicationController
  # GET /orc_nota_fiscals
  # GET /orc_nota_fiscals.xml
  def index
    @orc_nota_fiscals = OrcNotaFiscal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_nota_fiscals }
    end
  end

  # GET /orc_nota_fiscals/1
  # GET /orc_nota_fiscals/1.xml
  def show
    @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_nota_fiscal }
    end
  end

  # GET /orc_nota_fiscals/new
  # GET /orc_nota_fiscals/new.xml
  def new
    @orc_nota_fiscal = OrcNotaFiscal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_nota_fiscal }
    end
  end

  # GET /orc_nota_fiscals/1/edit
  def edit
    @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])
  end

  # POST /orc_nota_fiscals
  # POST /orc_nota_fiscals.xml
  def create
    @orc_nota_fiscal = OrcNotaFiscal.new(params[:orc_nota_fiscal])

    respond_to do |format|
      if @orc_nota_fiscal.save
        flash[:notice] = 'OrcNotaFiscal was successfully created.'
        format.html { redirect_to(@orc_nota_fiscal) }
        format.xml  { render :xml => @orc_nota_fiscal, :status => :created, :location => @orc_nota_fiscal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_nota_fiscal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_nota_fiscals/1
  # PUT /orc_nota_fiscals/1.xml
  def update
    @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])

    respond_to do |format|
      if @orc_nota_fiscal.update_attributes(params[:orc_nota_fiscal])
        flash[:notice] = 'OrcNotaFiscal was successfully updated.'
        format.html { redirect_to(@orc_nota_fiscal) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_nota_fiscal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_nota_fiscals/1
  # DELETE /orc_nota_fiscals/1.xml
  def destroy
    @orc_nota_fiscal = OrcNotaFiscal.find(params[:id])
    @orc_nota_fiscal.destroy

    respond_to do |format|
      format.html { redirect_to(orc_nota_fiscals_url) }
      format.xml  { head :ok }
    end
  end
end
