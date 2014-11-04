class CurriculosController < ApplicationController
  # GET /curriculos
  # GET /curriculos.xml


   def index
     if params[:type_of].to_i == 8
       @contador = Curriculo.all(:conditions => ["ATUACAO like ? AND STATUS <> 'DESCONSIDERAR'","INFORMÁTICA"]).count
       @curriculos = Curriculo.all(:conditions => ["ATUACAO like ? AND STATUS <> 'DESCONSIDERAR'","INFORMÁTICA"],:order => 'nome ASC')
       render :update do |page|
         page.replace_html 'curriculos', :partial => "curriculos"
       end
        else if params[:type_of].to_i == 2
            @contador = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ?","INFORMÁTICA"]).count
            @curriculos = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ?","INFORMÁTICA"],:order => 'created_at DESC')
            render :update do |page|
              page.replace_html 'curriculos', :partial => "curriculos"
            end
            else if params[:type_of].to_i == 3
              @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-0","INFORMÁTICA"],:order => 'nome ASC').count
              @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-0","INFORMÁTICA"],:order => 'nome ASC',:order => 'nome ASC')
              render :update do |page|
                 page.replace_html 'curriculos', :partial => "curriculos"
              end
              else if params[:type_of].to_i == 4
                @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-1","INFORMÁTICA"],:order => 'nome ASC').count
                @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-1","INFORMÁTICA"],:order => 'nome ASC',:order => 'nome ASC')
                render :update do |page|
                   page.replace_html 'curriculos', :partial => "curriculos"
                end
                else if params[:type_of].to_i == 5
                  @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-2","INFORMÁTICA"],:order => 'nome ASC').count
                  @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-2","INFORMÁTICA"],:order => 'nome ASC',:order => 'nome ASC')
                  render :update do |page|
                     page.replace_html 'curriculos', :partial => "curriculos"
                  end
                  else if params[:type_of].to_i == 6
                  @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-3","INFORMÁTICA"],:order => 'nome ASC').count
                  @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-3","INFORMÁTICA"],:order => 'nome ASC',:order => 'nome ASC')
                  render :update do |page|
                     page.replace_html 'curriculos', :partial => "curriculos"
                  end
                  else if params[:type_of].to_i == 1
                     @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "CONTRATADO","INFORMÁTICA"],:order => 'nome ASC').count
                     @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "CONTRATADO","INFORMÁTICA"],:order => 'nome ASC')
                     render :update do |page|
                       page.replace_html 'curriculos', :partial => "curriculos"
                     end
                      else if params[:type_of].to_i == 7
                         @contador = Curriculo.all(:conditions => ["STATUS != 'CONTRATADO'AND ATUACAO like ?","INFORMÁTICA"],:order => 'nome ASC').count
                         @curriculos = Curriculo.all(:conditions => ["STATUS != 'CONTRATADO' AND ATUACAO like ?" , "INFORMÁTICA" ],:order => 'nome ASC')
                         render :update do |page|
                           page.replace_html 'curriculos', :partial => "curriculos"
                         end
                         else if params[:type_of].to_i == 9
                           @contador = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ? AND PERIODO like ?","INFORMÁTICA", "MATUTINO"]).count
                           @curriculos = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ? AND PERIODO like ?","INFORMÁTICA", "MATUTINO"],:order => 'created_at DESC')
                           render :update do |page|
                              page.replace_html 'curriculos', :partial => "curriculos"
                           end
                           else if params[:type_of].to_i == 10
                             @contador = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ? AND PERIODO like ?","INFORMÁTICA", "VESPERTINO"]).count
                             @curriculos = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ? AND PERIODO like ?","INFORMÁTICA", "VESPERTINO"],:order => 'created_at DESC')
                             render :update do |page|
                               page.replace_html 'curriculos', :partial => "curriculos"
                              end
                             else if params[:type_of].to_i == 11
                                @contador = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ? AND PERIODO like ?","INFORMÁTICA", "NOTURNO"]).count
                                @curriculos = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ? AND PERIODO like ?","INFORMÁTICA", "NOTURNO"],:order => 'created_at DESC')
                                render :update do |page|
                                   page.replace_html 'curriculos', :partial => "curriculos"
                                end
                              end
                           end
                         end
                       end
                     end
                   end
                 end
               end
            end
          end
      end
  end

  def indexadmin
     if params[:type_of].to_i == 8
       @contador = Curriculo.all(:conditions => ["ATUACAO like ?","ADMINISTRATIVA"]).count
       @curriculos = Curriculo.all(:conditions => ["ATUACAO like ?","ADMINISTRATIVA"],:order => 'nome ASC')
       render :update do |page|
         page.replace_html 'curriculos', :partial => "curriculos"
       end
        else if params[:type_of].to_i == 2
            @contador = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ?","ADMINISTRATIVA"]).count
            @curriculos = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ?","ADMINISTRATIVA"],:order => 'created_at DESC')
            render :update do |page|
              page.replace_html 'curriculos', :partial => "curriculos"
            end
            else if params[:type_of].to_i == 3
              @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-0","ADMINISTRATIVA"],:order => 'nome ASC').count
              @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-0","ADMINISTRATIVA"],:order => 'nome ASC',:order => 'nome ASC')
              render :update do |page|
                 page.replace_html 'curriculos', :partial => "curriculos"
              end
              else if params[:type_of].to_i == 4
                @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-1","ADMINISTRATIVA"],:order => 'nome ASC').count
                @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-1","ADMINISTRATIVA"],:order => 'nome ASC',:order => 'nome ASC')
                render :update do |page|
                   page.replace_html 'curriculos', :partial => "curriculos"
                end
                else if params[:type_of].to_i == 5
                  @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-2","ADMINISTRATIVA"],:order => 'nome ASC').count
                  @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-2","ADMINISTRATIVA"],:order => 'nome ASC',:order => 'nome ASC')
                  render :update do |page|
                     page.replace_html 'curriculos', :partial => "curriculos"
                  end
                  else if params[:type_of].to_i == 6
                  @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-3","ADMINISTRATIVA"],:order => 'nome ASC').count
                  @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-3","ADMINISTRATIVA"],:order => 'nome ASC',:order => 'nome ASC')
                  render :update do |page|
                     page.replace_html 'curriculos', :partial => "curriculos"
                  end
                  else if params[:type_of].to_i == 1
                     @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "CONTRATADO","ADMINISTRATIVA"],:order => 'nome ASC').count
                     @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "CONTRATADO","ADMINISTRATIVA"],:order => 'nome ASC')
                     render :update do |page|
                       page.replace_html 'curriculos', :partial => "curriculos"
                     end
                      else if params[:type_of].to_i == 7
                         @contador = Curriculo.all(:conditions => ["STATUS != 'CONTRATADO'AND ATUACAO like ?","ADMINISTRATIVA"],:order => 'nome ASC').count
                         @curriculos = Curriculo.all(:conditions => ["STATUS != 'CONTRATADO' AND ATUACAO like ?" , "ADMINISTRATIVA" ],:order => 'nome ASC')
                         render :update do |page|
                           page.replace_html 'curriculos', :partial => "curriculos"
                         end
                     end
                  end
                 end
                end
              end
            end
          end
      end
  end

  def indexpedag
     if params[:type_of].to_i == 8
       @contador = Curriculo.all(:conditions => ["ATUACAO like ?","PEDAGÓGICA"]).count
       @curriculos = Curriculo.all(:conditions => ["ATUACAO like ?","PEDAGÓGICA"],:order => 'nome ASC')
       render :update do |page|
         page.replace_html 'curriculos', :partial => "curriculos"
       end
        else if params[:type_of].to_i == 2
            @contador = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ?","PEDAGÓGICA"]).count
            @curriculos = Curriculo.all(:conditions => ["STATUS is null AND ATUACAO like ?","PEDAGÓGICA"],:order => 'created_at DESC')
            render :update do |page|
              page.replace_html 'curriculos', :partial => "curriculos"
            end
            else if params[:type_of].to_i == 3
              @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-0","PEDAGÓGICA"],:order => 'nome ASC').count
              @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-0","PEDAGÓGICA"],:order => 'nome ASC',:order => 'nome ASC')
              render :update do |page|
                 page.replace_html 'curriculos', :partial => "curriculos"
              end
              else if params[:type_of].to_i == 4
                @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-1","PEDAGÓGICA"],:order => 'nome ASC').count
                @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-1","PEDAGÓGICA"],:order => 'nome ASC',:order => 'nome ASC')
                render :update do |page|
                   page.replace_html 'curriculos', :partial => "curriculos"
                end
                else if params[:type_of].to_i == 5
                  @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-2","PEDAGÓGICA"],:order => 'nome ASC').count
                  @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-2","PEDAGÓGICA"],:order => 'nome ASC',:order => 'nome ASC')
                  render :update do |page|
                     page.replace_html 'curriculos', :partial => "curriculos"
                  end
                  else if params[:type_of].to_i == 6
                  @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-3","PEDAGÓGICA"],:order => 'nome ASC').count
                  @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "NIVEL-3","PEDAGÓGICA"],:order => 'nome ASC',:order => 'nome ASC')
                  render :update do |page|
                     page.replace_html 'curriculos', :partial => "curriculos"
                  end
                  else if params[:type_of].to_i == 1
                     @contador = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "CONTRATADO","PEDAGÓGICA"],:order => 'nome ASC').count
                     @curriculos = Curriculo.all(:conditions => ["STATUS like ? AND ATUACAO like ?", "CONTRATADO","PEDAGÓGICA"],:order => 'nome ASC')
                     render :update do |page|
                       page.replace_html 'curriculos', :partial => "curriculos"
                     end
                      else if params[:type_of].to_i == 7
                         @contador = Curriculo.all(:conditions => ["STATUS != 'CONTRATADO'AND ATUACAO like ?","PEDAGÓGICA"],:order => 'nome ASC').count
                         @curriculos = Curriculo.all(:conditions => ["STATUS != 'CONTRATADO' AND ATUACAO like ?" , "PEDAGÓGICA" ],:order => 'nome ASC')
                         render :update do |page|
                           page.replace_html 'curriculos', :partial => "curriculos"
                         end
                     end
                  end
                 end
                end
              end
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
        format.html { render :action => "index" }
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
