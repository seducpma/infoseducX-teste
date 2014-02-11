class ServicosInternosController < ApplicationController
  # GET /servicos_internos
  # GET /servicos_internos.xml

 def consulta
    render 'consulta'
 end

def consultaint
   unless params[:search].present?
     if params[:type_of].to_i == 4
       @contador = ServicosInterno.all.count
       @servicos_internos = ServicosInterno.all(:order => 'id DESC')
       render :update do |page|
         page.replace_html 'interno', :partial => "internos"
       end
     end
   else
      if params[:type_of].to_i == 1
          @contador = ServicosInterno.all(:conditions => ["assunto like ?", "%" + params[:search].to_s + "%"]).count
          @servicos_internos = ServicosInterno.all(:conditions => ["assunto like ?", "%" + params[:search].to_s + "%"],:order => 'id ASC')
          render :update do |page|
            page.replace_html 'interno', :partial => "internos"
          end
          else if params[:type_of].to_i == 2
          @contador = ServicosInterno.all(:conditions => ["emissor like ?", "%" + params[:search].to_s + "%"]).count
          @servicos_internos = ServicosInterno.all(:conditions => ["emissor like ?", "%" + params[:search].to_s + "%"],:order => 'id ASC')
          render :update do |page|
            page.replace_html 'interno', :partial => "internos"
          end
            else if params[:type_of].to_i == 3
          @contador = ServicosInterno.all(:conditions => ["destinatario like ?", "%" + params[:search].to_s + "%"]).count
          @servicos_internos = ServicosInterno.all(:conditions => ["destinatario like ?", "%" + params[:search].to_s + "%"],:order => 'id ASC')
          render :update do |page|
            page.replace_html 'interno', :partial => "internos"
          end
         end
       end
     end
   end
end

  def index
    @servicos_internos = ServicosInterno.all(:order => 'id DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servicos_internos }
    end
  end

  # GET /servicos_internos/1
  # GET /servicos_internos/1.xml
  def show
    @servicos_interno = ServicosInterno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @servicos_interno }
    end
  end

  # GET /servicos_internos/new
  # GET /servicos_internos/new.xml
  def new
    @servicos_interno = ServicosInterno.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @servicos_interno }
    end
  end

  # GET /servicos_internos/1/edit
  def edit
    @servicos_interno = ServicosInterno.find(params[:id])
  end

  # POST /servicos_internos
  # POST /servicos_internos.xml
  def create
    @servicos_interno = ServicosInterno.new(params[:servicos_interno])

    respond_to do |format|
      if @servicos_interno.save
        flash[:notice] = 'CADASTRADO COM SUCESSO.'
        format.html {  render :action => "show" }
        format.xml  { render :xml => @servicos_interno, :status => :created, :location => @servicos_interno }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @servicos_interno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /servicos_internos/1
  # PUT /servicos_internos/1.xml
  def update
    @servicos_interno = ServicosInterno.find(params[:id])

    respond_to do |format|
      if @servicos_interno.update_attributes(params[:servicos_interno])
        flash[:notice] = 'CADASTRADO COM SUCESSO.'
        format.html { redirect_to(@servicos_interno) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @servicos_interno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /servicos_internos/1
  # DELETE /servicos_internos/1.xml
  def destroy
    @servicos_interno = ServicosInterno.find(params[:id])
    @servicos_interno.destroy

    respond_to do |format|
      format.html { redirect_to(servicos_internos_url) }
      format.xml  { head :ok }
    end
  end
end
