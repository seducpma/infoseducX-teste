class OrcUniDespesasController < ApplicationController
  # GET /orc_uni_despesas
  # GET /orc_uni_despesas.xml
  def index
    @orc_uni_despesas = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_uni_despesas }
    end
  end

  # GET /orc_uni_despesas/1
  # GET /orc_uni_despesas/1.xml
  def show
    @orc_uni_despesa = OrcUniDespesa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_uni_despesa }
    end
  end

  # GET /orc_uni_despesas/new
  # GET /orc_uni_despesas/new.xml
  def new
    @orc_uni_despesa = OrcUniDespesa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_uni_despesa }
    end
  end

  # GET /orc_uni_despesas/1/edit
  def edit
    @orc_uni_despesa = OrcUniDespesa.find(params[:id])
  end

  # POST /orc_uni_despesas
  # POST /orc_uni_despesas.xml
  def create
    @orc_uni_despesa = OrcUniDespesa.new(params[:orc_uni_despesa])

    respond_to do |format|
      if @orc_uni_despesa.save
        flash[:notice] = 'OrcUniDespesa was successfully created.'
        format.html { redirect_to(@orc_uni_despesa) }
        format.xml  { render :xml => @orc_uni_despesa, :status => :created, :location => @orc_uni_despesa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_uni_despesa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_uni_despesas/1
  # PUT /orc_uni_despesas/1.xml
  def update
    @orc_uni_despesa = OrcUniDespesa.find(params[:id])

    respond_to do |format|
      if @orc_uni_despesa.update_attributes(params[:orc_uni_despesa])
        flash[:notice] = 'OrcUniDespesa was successfully updated.'
        format.html { redirect_to(@orc_uni_despesa) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_uni_despesa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_uni_despesas/1
  # DELETE /orc_uni_despesas/1.xml
  def destroy
    @orc_uni_despesa = OrcUniDespesa.find(params[:id])
    @orc_uni_despesa.destroy

    respond_to do |format|
      format.html { redirect_to(orc_uni_despesas_url) }
      format.xml  { head :ok }
    end
  end
end
