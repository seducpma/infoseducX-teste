class PrefprotocolosController < ApplicationController
  # GET /prefprotocolos
  # GET /prefprotocolos.xml

 before_filter :load_depto

def load_depto
    @depto = Prefprotocolo.find(:all, :order => 'destino ASC')
end


  def consulta
      if params[:type_of].nil?
        @prefprotocolos = Prefprotocolo.all(:order =>  'created_at DESC')
      end
      session[:testeI]=0
    render 'consulta'
 end

def protocolo
   #unless params[:search].present?
     if params[:type_of].to_i == 4
       if session[:testeI]==1
         @contador = Prefprotocolo.all(:conditions => ["encerrado = ?","0"] ).count
         @prefprotocolos = Prefprotocolo.all(:conditions => ["encerrado = ?","0"],:order => 'created_at DESC' )
         render :update do |page|
           page.replace_html 'protocolo', :partial => "protocolosindex"
         end
      session[:testeI]=1;
      else
         @contador = Prefprotocolo.all.count
         @prefprotocolos = Prefprotocolo.all(:order =>  'created_at DESC')
         render :update do |page|
           page.replace_html 'protocolo', :partial => "protocolos"
         end
       session[:testeI]=0;
      end
     end
   #else
      if params[:type_of].to_i == 1
          @contador = Prefprotocolo.all(:conditions => ["assunto like ?", "%" + params[:search].to_s + "%"]).count
          @prefprotocolos = Prefprotocolo.all(:conditions => ["assunto like ?", "%" + params[:search].to_s + "%"],:order =>  'created_at DESC')
          render :update do |page|
            page.replace_html 'protocolo', :partial => "protocolos"
          end
          else if params[:type_of].to_i == 2
           @contador = Prefprotocolo.all(:conditions => ["de like ?", "%" + params[:search].to_s + "%"]).count
           @prefprotocolos = Prefprotocolo.all(:conditions => ["de like ?", "%" + params[:search].to_s + "%"],:order =>  'created_at DESC')
           render :update do |page|
            page.replace_html 'protocolo', :partial => "protocolos"
           end
          else if params[:type_of].to_i == 3

             if (session[:testeI]==1)
              if (params[:search].to_s == 'PROTOCOLO_INTERNO')
               @contador = Prefprotocolo.all(:conditions => ["destino like ? and encerrado = ? ", "%" + params[:search].to_s + "%", "0"]).count
               @prefprotocolos = Prefprotocolo.all(:conditions => ["destino like ?", "%" + params[:search].to_s + "%"],:order =>  'updated_at DESC')
              else
               @contador = Prefprotocolo.all(:conditions => ["destino like ? and encerrado = ? ", "%" + params[:search].to_s + "%", "0"]).count
               @prefprotocolos = Prefprotocolo.all(:conditions => ["destino like ? and encerrado = ?", "%" + params[:search].to_s + "%", "0"],:order =>  'updated_at DESC')
              end
                render :update do |page|
                page.replace_html 'protocolo', :partial => "protocolosindex"
              end

             else
               @contador = Prefprotocolo.all(:conditions => ["destino like ?", "%" + params[:search].to_s + "%"]).count
               @prefprotocolos = Prefprotocolo.all(:conditions => ["destino like ?", "%" + params[:search].to_s + "%"],:order =>  'updated_at DESC')
               render :update do |page|
                page.replace_html 'protocolo', :partial => "protocolos"
               end
             end



          else if params[:type_of].to_i == 7
           @contador = Prefprotocolo.all(:conditions => ["codigo like ?", "%" + params[:search].to_s + "%"]).count
           @prefprotocolos = Prefprotocolo.all(:conditions => ["codigo like ?", "%" + params[:search].to_s + "%"],:order =>  'created_at DESC')
           render :update do |page|
            page.replace_html 'protocolo', :partial => "protocolos"
           end
         end
       end
     end
   end
   #end
   #unless params[:search].present?
       if params[:type_of].to_i == 5
        @contador = Prefprotocolo.all(:conditions => ["encerrado = ?","0"]).count
        @prefprotocolos = Prefprotocolo.all(:conditions => ["encerrado = ?","0"],:order =>  'created_at DESC' )
        render :update do |page|
         page.replace_html 'protocolo', :partial => "protocolos"
        end
        session[:testeI]=0;
       else if params[:type_of].to_i == 6
         if (session[:testeI]==1)
            @contador = Prefprotocolo.all(:conditions => ["encerrado = ?","1"]).count
            @prefprotocolos = Prefprotocolo.all(:conditions => ["encerrado =?","1"],:order =>  'created_at DESC')
           session[:testeI]=1
            render :update do |page|
              page.replace_html 'protocolo', :partial => "protocolosindex"
            end
         else
            @contador = Prefprotocolo.all(:conditions => ["encerrado = ?","1"]).count
            @prefprotocolos = Prefprotocolo.all(:conditions => ["encerrado =?","1"],:order =>  'created_at DESC')
            render :update do |page|
              page.replace_html 'protocolo', :partial => "protocolos"
            end
            session[:testeI]=0;
         end
     end
   end
  #end
 
end


def index
 @prefprotocolos = Prefprotocolo.all(:conditions => ["encerrado = ?", "0"], :order => 'id DESC' )
  session[:testeI]=1
end


def indexe
    @prefprotocolos = Prefprotocolo.all(:conditions => ["encerrado = ?", "1"], :order => 'id DESC' )
  session[:testeI]=1
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prefprotocolos }
    end
 
  end

  # GET /prefprotocolos/1
  # GET /prefprotocolos/1.xml
  def show
    @prefprotocolo = Prefprotocolo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prefprotocolo }
    end
  end

  # GET /prefprotocolos/new
  # GET /prefprotocolos/new.xml
  def new
    @prefprotocolo = Prefprotocolo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prefprotocolo }
    end
  end

  # GET /prefprotocolos/1/edit
  def edit
    @prefprotocolo = Prefprotocolo.find(params[:id])
     session[:id] = params[:id]
  end

 def reabrir
    @prefprotocolo = Prefprotocolo.find(params[:id])
     session[:id] = params[:id]

  end


  # POST /prefprotocolos
  # POST /prefprotocolos.xml
  def create
    @prefprotocolo = Prefprotocolo.new(params[:prefprotocolo])

    respond_to do |format|
      if @prefprotocolo.save
        flash[:notice] = 'Cadastrado com sucesso.'
        format.html { redirect_to(@prefprotocolo) }
        format.xml  { render :xml => @prefprotocolo, :status => :created, :location => @prefprotocolo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prefprotocolo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prefprotocolos/1
  # PUT /prefprotocolos/1.xml
  def update
    @prefprotocolo = Prefprotocolo.find(params[:id])

    respond_to do |format|
      if @prefprotocolo.update_attributes(params[:prefprotocolo])
        flash[:notice] = 'Cadastrado com sucesso.'
        format.html { redirect_to(@prefprotocolo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prefprotocolo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prefprotocolos/1
  # DELETE /prefprotocolos/1.xml
  def destroy
    @prefprotocolo = Prefprotocolo.find(params[:id])
    @prefprotocolo.destroy

    respond_to do |format|
      format.html { redirect_to(prefprotocolos_url) }
      format.xml  { head :ok }
    end
  end

#def create_despachos
#      @despacho = Despacho.new(params[:despacho])
#      $teste=@despacho.despacho
#      $teste2=@despacho.para
#      $teste3=@despacho.destino
#      if @despacho.save
#        @despachos = Despacho.all(:conditions => ["prefprotocolo_id is null"])
#        @despachos.id =
##        session[:despacho_id] = @despacho.id

#          redirect_to(new_despacho_path)
#      end
#    end


def create_despacho
      @despacho = Despacho.new(params[:despacho])
      @prefprotocolo = Prefprotocolo.find(session[:id])
      @despacho.prefprotocolo_id =@prefprotocolo.id
      @despacho.procedencia =@prefprotocolo.destino
      @despacho.data_saida = Time.now
      if @despacho.para =='ENCERRADO'
        @prefprotocolo.encerrado = true
        @prefprotocolo.data_encerramento = Time.now
        @prefprotocolo.save
      else
        @despacho.para =='ENCERRADO'
        @prefprotocolo.encerrado = false
        @prefprotocolo.save
      end
      if @despacho.save
        render :update do |page|
          page.replace_html 'dados', :partial => "despachos"
          page.replace_html 'edit'
        end
       end

end

def destinofinal
  render :partial => 'consulta'

end

def teste
 render "despacho"
end

end
