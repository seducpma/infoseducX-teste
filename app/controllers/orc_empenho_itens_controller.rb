class OrcEmpenhoItensController < ApplicationController
  # GET /orc_empenho_itens
  # GET /orc_empenho_itens.xml
  def index
    @orc_empenho_itens = OrcEmpenhoIten.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_empenho_itens }
    end
  end

  # GET /orc_empenho_itens/1
  # GET /orc_empenho_itens/1.xml
  def show
    @orc_empenho_iten = OrcEmpenhoIten.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_empenho_iten }
    end
  end

  # GET /orc_empenho_itens/new
  # GET /orc_empenho_itens/new.xml
  def new
    @orc_empenho_iten = OrcEmpenhoIten.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_empenho_iten }
    end
  end

  # GET /orc_empenho_itens/1/edit
  def edit
    @orc_empenho_iten = OrcEmpenhoIten.find(params[:id])
  end

  # POST /orc_empenho_itens
  # POST /orc_empenho_itens.xml
  def create
    @orc_empenho_iten = OrcEmpenhoIten.new(params[:orc_empenho_iten])

    respond_to do |format|
      if @orc_empenho_iten.save
        flash[:notice] = 'OrcEmpenhoIten was successfully created.'
        format.html { redirect_to(@orc_empenho_iten) }
        format.xml  { render :xml => @orc_empenho_iten, :status => :created, :location => @orc_empenho_iten }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_empenho_iten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_empenho_itens/1
  # PUT /orc_empenho_itens/1.xml
  def update
    @orc_empenho_iten = OrcEmpenhoIten.find(params[:id])

    respond_to do |format|
      if @orc_empenho_iten.update_attributes(params[:orc_empenho_iten])
        flash[:notice] = 'OrcEmpenhoIten was successfully updated.'
        format.html { redirect_to(@orc_empenho_iten) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_empenho_iten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_empenho_itens/1
  # DELETE /orc_empenho_itens/1.xml
  def destroy
    @orc_empenho_iten = OrcEmpenhoIten.find(params[:id])
    @orc_empenho_iten.destroy

    respond_to do |format|
      format.html { redirect_to(orc_empenho_itens_url) }
      format.xml  { head :ok }
    end
  end
end
