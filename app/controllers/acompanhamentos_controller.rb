class AcompanhamentosController < ApplicationController
  # GET /acompanhamentos
  # GET /acompanhamentos.xml
  def index
    @acompanhamentos = Acompanhamento.all(:conditions => ["encerrado = ?","0"],:order =>  'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @acompanhamentos }
    end
  end

  # GET /acompanhamentos/1
  # GET /acompanhamentos/1.xml
  def show
    @acompanhamento = Acompanhamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @acompanhamento }
    end
  end

  # GET /acompanhamentos/new
  # GET /acompanhamentos/new.xml
  def new
    @acompanhamento = Acompanhamento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @acompanhamento }
    end
  end

  # GET /acompanhamentos/1/edit
  def edit
    @acompanhamento = Acompanhamento.find(params[:id])
    $id = params[:id]
  end

 def editar
    @acompanhamento = Acompanhamento.find(params[:id])
    $id = params[:id]
  end

  # POST /acompanhamentos
  # POST /acompanhamentos.xml
  def create
    @acompanhamento = Acompanhamento.new(params[:acompanhamento])

    respond_to do |format|
      if @acompanhamento.save
        flash[:notice] = 'Acompanhamento was successfully created.'
        format.html { redirect_to(@acompanhamento) }
        format.xml  { render :xml => @acompanhamento, :status => :created, :location => @acompanhamento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @acompanhamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /acompanhamentos/1
  # PUT /acompanhamentos/1.xml
  def update
    @acompanhamento = Acompanhamento.find(params[:id])
    @acompanhamento.data_encerrado = Time.now
    respond_to do |format|
      if @acompanhamento.update_attributes(params[:acompanhamento])
        flash[:notice] = 'Acompanhamento was successfully updated.'
        format.html { redirect_to(@acompanhamento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @acompanhamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /acompanhamentos/1
  # DELETE /acompanhamentos/1.xml
  def destroy
    @acompanhamento = Acompanhamento.find(params[:id])
    @acompanhamento.destroy

    respond_to do |format|
      format.html { redirect_to(acompanhamentos_url) }
      format.xml  { head :ok }
    end
  end


def create_acompanhamento_despacho
      @acompanhamento_despacho = AcompanhamentoDespacho.new(params[:acompanhamento_despacho])
      @acompanhamento = Acompanhamento.find($id)
      @acompanhamento_despacho.acompanhamento_id = @acompanhamento.id
      @acompanhamento_despacho.data = Time.now
      @acompanhamento.data_encerrado = Time.now
      if params[:type_of].to_i == 1
        @acompanhamento.encerrado = 0
        @acompanhamento_despacho.aceite ="RECUSADO"
        @acompanhamento.save
        
      end
      if params[:type_of].to_i == 2
        @acompanhamento.encerrado = 1
        @acompanhamento_despacho.aceite ="ACEITADO"
        @acompanhamento.save
      end
      if @acompanhamento_despacho.save
        render :update do |page|
          page.replace_html 'dados', :partial => "acompanhamento_despachos"
          page.replace_html 'edit'
        end
       end

end

  def consulta
      if params[:type_of].nil?
          @acompanhamentos = Acompanhamento.all:order => 'created_at DESC'
      end
      $testeI=0;
    render 'consulta'
 end

def acompanhamento
     if params[:type_of].to_i == 3
         @contador = Acompanhamento.all.count
         @acompanhamentos = Acompanhamento.all:order => 'created_at DESC'
         render :update do |page|
           page.replace_html 'protocolo', :partial => "acompanhamento"
         end
     end
     if params[:type_of].to_i == 1
          @contador = Acompanhamento.all(:conditions =>  ["encerrado = ?","0"]).count
          @acompanhamentos = Acompanhamento.all(:conditions => ["encerrado = ?","0"],:order =>  'created_at DESC')
          render :update do |page|
            page.replace_html 'protocolo', :partial => "acompanhamento"
          end
       else if params[:type_of].to_i == 2
          @contador = Acompanhamento.all(:conditions =>  ["encerrado = ?","1"]).count
          @acompanhamentos = Acompanhamento.all(:conditions => ["encerrado = ?","1"],:order =>  'created_at DESC')
           render :update do |page|
             page.replace_html 'protocolo', :partial => "acompanhamento"
           end
          else if params[:type_of].to_i == 4
             @contador = Acompanhamento.all(:conditions => ["codigo like ?", "%" + params[:search].to_s + "%"]).count
             @acompanhamentos = Acompanhamento.all(:conditions => ["codigo like ?", "%" + params[:search].to_s + "%"],:order =>  'created_at DESC')
             render :update do |page|
               page.replace_html 'protocolo', :partial => "acompanhamento"
             end
            else if params[:type_of].to_i == 5
               @contador = Acompanhamento.all(:conditions => ["assunto like ?", "%" + params[:search].to_s + "%"]).count
               @acompanhamentos = Acompanhamento.all(:conditions => ["assunto like ?", "%" + params[:search].to_s + "%"],:order =>  'created_at DESC')
               render :update do |page|
                page.replace_html 'protocolo', :partial => "acompanhamento"
               end
             else if params[:type_of].to_i == 6
               @contador = Acompanhamento.all(:conditions => ["crianca like ?", "%" + params[:search].to_s + "%"]).count
               @acompanhamentos = Acompanhamento.all(:conditions => ["crianca like ?", "%" + params[:search].to_s + "%"],:order =>  'created_at DESC')
               render :update do |page|
                page.replace_html 'protocolo', :partial => "acompanhamento"
               end
            end
          end
        end
     end
   end
end


end
