class OrcUniOrcamentariasController < ApplicationController
  # GET /orc_uni_orcamentarias
  # GET /orc_uni_orcamentarias.xml

 before_filter :load_iniciais

 def load_iniciais
       @despesas = OrcUniDespesa.all(:conditions => ["ano = ?", Time.now.year])
       @orc_uni_orcamentaria_ano= OrcUniOrcamentaria.find(:all, :select => 'distinct(ano)')
       @orc_uni_orcamentaria_descricao= OrcUniOrcamentaria.find(:all, :select => "id, descricao, CONCAT( ano, ' - ', descricao ) AS descricao_ano", :order => ' descricao ASC' )

       
       
 end

  def index
    @orc_uni_orcamentarias = OrcUniOrcamentaria.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orc_uni_orcamentarias }
    end
  end

  # GET /orc_uni_orcamentarias/1
  # GET /orc_uni_orcamentarias/1.xml
  def show
    @orc_uni_orcamentaria = OrcUniOrcamentaria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orc_uni_orcamentaria }
    end
  end

  # GET /orc_uni_orcamentarias/new
  # GET /orc_uni_orcamentarias/new.xml
  def new
    @orc_uni_orcamentaria = OrcUniOrcamentaria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orc_uni_orcamentaria }
    end
  end

  # GET /orc_uni_orcamentarias/1/edit
  def edit
    @orc_uni_orcamentaria = OrcUniOrcamentaria.find(params[:id])
  end

  # POST /orc_uni_orcamentarias
  # POST /orc_uni_orcamentarias.xml
  def create
    @orc_uni_orcamentaria = OrcUniOrcamentaria.new(params[:orc_uni_orcamentaria])

    respond_to do |format|
      if @orc_uni_orcamentaria.save
        flash[:notice] = 'OrcUniOrcamentaria was successfully created.'
        format.html { redirect_to(@orc_uni_orcamentaria) }
        format.xml  { render :xml => @orc_uni_orcamentaria, :status => :created, :location => @orc_uni_orcamentaria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orc_uni_orcamentaria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orc_uni_orcamentarias/1
  # PUT /orc_uni_orcamentarias/1.xml
  def update
    @orc_uni_orcamentaria = OrcUniOrcamentaria.find(params[:id])

    respond_to do |format|
      if @orc_uni_orcamentaria.update_attributes(params[:orc_uni_orcamentaria])
        flash[:notice] = 'OrcUniOrcamentaria was successfully updated.'
        format.html { redirect_to(@orc_uni_orcamentaria) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orc_uni_orcamentaria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orc_uni_orcamentarias/1
  # DELETE /orc_uni_orcamentarias/1.xml
  def destroy
    @orc_uni_orcamentaria = OrcUniOrcamentaria.find(params[:id])
    @orc_uni_orcamentaria.destroy

    respond_to do |format|
      format.html { redirect_to(orc_uni_orcamentarias_url) }
      format.xml  { head :ok }
    end
  end


 def consulta_orcamentaria
     if params[:type_of].to_i == 4   #todas
                   @orc_uni_orcamentarias = OrcUniOrcamentaria.find(:all, :order => 'ano ASC, descricao ASC')
                   t=0
               render :update do |page|
                  page.replace_html 'consultaorcamentaria', :partial => "un_orcamentarias"
               end
    end
    
end

 def orcamentaria_ano
   @orc_uni_orcamentarias = OrcUniOrcamentaria.find(:all, :conditions => ['ano = ?', params[:orc_uni_orcamentaria_ano]], :order => 'ano ASC, descricao ASC')
   render :partial => "un_orcamentarias"
 end

 def orcamentaria_descricao
   @orc_uni_orcamentarias = OrcUniOrcamentaria.find(:all, :conditions => ['descricao = ?', params[:orc_uni_orcamentaria_descricao]], :order => 'ano ASC, descricao ASC')
   render :partial => "un_orcamentarias"
 end

  def orcamentaria_despesa
   @orc_uni_orcamentarias = OrcUniOrcamentaria.find(:all, :conditions => ['orc_uni_despesa_id = ?', params[:orc_uni_orcamentaria_orc_uni_despesa_id]], :order => 'ano ASC, descricao ASC')
   render :partial => "un_orcamentarias"
 end


end
