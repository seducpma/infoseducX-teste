class CurriculosController < ApplicationController
  # GET /curriculos
  # GET /curriculos.xml


  def index
   unless params[:search].present?
     if params[:type_of].to_i == 7
       @contador = Curriculo.all.count
       @curriculos = Curriculo.all(:order => 'nome ASC')
       render :update do |page|
         page.replace_html 'curriculos', :partial => "curriculos"
       end
        else if params[:type_of].to_i == 2
            @contador = Curriculo.all(:conditions => ["STATUS is null"]).count
            @curriculos = Curriculo.all(:conditions => ["STATUS is null"],:order => 'nome ASC')
            render :update do |page|
              page.replace_html 'curriculos', :partial => "curriculos"
            end
            else if params[:type_of].to_i == 3
              @contador = Curriculo.all(:conditions => ["STATUS like ?", "NIVEL-0"],:order => 'nome ASC').count
              @curriculos = Curriculo.all(:conditions => ["STATUS like?", "NIVEL-0"],:order => 'nome ASC',:order => 'nome ASC')
              render :update do |page|
                 page.replace_html 'curriculos', :partial => "curriculos"
              end
              else if params[:type_of].to_i == 4
                @contador = Curriculo.all(:conditions => ["STATUS like ?", "NIVEL-1"],:order => 'nome ASC').count
                @curriculos = Curriculo.all(:conditions => ["STATUS like?", "NIVEL-1"],:order => 'nome ASC',:order => 'nome ASC')
                render :update do |page|
                   page.replace_html 'curriculos', :partial => "curriculos"
                end
                else if params[:type_of].to_i == 5
                  @contador = Curriculo.all(:conditions => ["STATUS like ?", "NIVEL-2"],:order => 'nome ASC').count
                  @curriculos = Curriculo.all(:conditions => ["STATUS like?", "NIVEL-2"],:order => 'nome ASC',:order => 'nome ASC')
                  render :update do |page|
                     page.replace_html 'curriculos', :partial => "curriculos"
                  end
                  else if params[:type_of].to_i == 6
                  @contador = Curriculo.all(:conditions => ["STATUS like ?", "NIVEL-3"],:order => 'nome ASC').count
                  @curriculos = Curriculo.all(:conditions => ["STATUS like?", "NIVEL-3"],:order => 'nome ASC',:order => 'nome ASC')
                  render :update do |page|
                     page.replace_html 'curriculos', :partial => "curriculos"
                  end
                  end
                end
              end
            end
          end
      end
   else
    if params[:type_of].to_i == 1
       @contador = Curriculo.all(:conditions => ["STATUS like ? and NOME like ?", "CONTRATADO", "%" + params[:search].to_s + "%"],:order => 'nome ASC').count
       @curriculos = Curriculo.all(:conditions => ["STATUS like ? and NOME like ?", "CONTRATADO", "%" + params[:search].to_s + "%"],:order => 'nome ASC',:order => 'nome ASC')
       render :update do |page|
         page.replace_html 'curriculos', :partial => "curriculos"
       end
     end
   end

  end

  # GET /curriculos/1
  # GET /curriculos/1.xml
  def show
    @curriculo = Curriculo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @curriculo }
    end
  end

 def curriculo
   @curriculo = Curriculo.find(params[:id])


 end

  # GET /curriculos/new
  # GET /curriculos/new.xml
  def new
    @curriculo = Curriculo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @curriculo }
    end
  end

  # GET /curriculos/1/edit
  def edit
    @curriculo = Curriculo.find(params[:id])
  end

  # POST /curriculos
  # POST /curriculos.xml
  def create
    @curriculo = Curriculo.new(params[:curriculo])

    respond_to do |format|
      if @curriculo.save
        flash[:notice] = 'CADASTRADO COM SUCESSO.'
        format.html { redirect_to(@curriculo) }
        format.xml  { render :xml => @curriculo, :status => :created, :location => @curriculo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @curriculo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /curriculos/1
  # PUT /curriculos/1.xml
  def update
    @curriculo = Curriculo.find(params[:id])

    respond_to do |format|
      if @curriculo.update_attributes(params[:curriculo])
        flash[:notice] = 'CADASTRADO COM SUCESSO'
        format.html { redirect_to(@curriculo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @curriculo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /curriculos/1
  # DELETE /curriculos/1.xml
  def destroy
    @curriculo = Curriculo.find(params[:id])
    @curriculo.destroy

    respond_to do |format|
      format.html { redirect_to(curriculos_url) }
      format.xml  { head :ok }
    end
  end
end
