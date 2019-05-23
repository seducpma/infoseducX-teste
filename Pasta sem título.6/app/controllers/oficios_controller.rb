class OficiosController < ApplicationController

    def consulta
        render 'consulta'
    end

 def oficio
    render 'oficio'
 end
 
    def consultaof
        unless params[:search].present?
            if params[:type_of].to_i == 4
                @contador = Oficio.all.count
                @oficios = Oficio.all(:order => 'id DESC')
                render :update do |page|
                    page.replace_html 'consultaoficio', :partial => "oficios"
                end
            end
        else
            if params[:type_of].to_i == 1
                @contador = Oficio.all(:conditions => ["assunto like ?", "%" + params[:search].to_s + "%"]).count
                @oficios = Oficio.all(:conditions => ["assunto like ?", "%" + params[:search].to_s + "%"],:order => 'id DESC')
                render :update do |page|
                    page.replace_html 'consultaoficio', :partial => "oficios"
                end
            else if params[:type_of].to_i == 2
                    @contador = Oficio.all(:conditions => ["emissor like ?", "%" + params[:search].to_s + "%"]).count
                    @oficios = Oficio.all(:conditions => ["emissor like ?", "%" + params[:search].to_s + "%"],:order => 'id DESC')
                    render :update do |page|
                        page.replace_html 'consultaoficio', :partial => "oficios"
                    end
                else if params[:type_of].to_i == 3
                        @contador = Oficio.all(:conditions => ["destinatario like ?", "%" + params[:search].to_s + "%"]).count
                        @oficios = Oficio.all(:conditions => ["destinatario like ?", "%" + params[:search].to_s + "%"],:order => 'id DESC')
                        render :update do |page|
                            page.replace_html 'consultaoficio', :partial => "oficios"
                        end
                    else if params[:type_of].to_i == 5
                            @contador = Oficio.all(:conditions => ["codigo like ?", "%" + params[:search].to_s + "%"]).count
                            @oficios = Oficio.all(:conditions => ["codigo like ?", "%" + params[:search].to_s + "%"],:order => 'id DESC')
                            render :update do |page|
                                page.replace_html 'consultaoficio', :partial => "oficios"
                            end
                        end
                    end
                end
            end
        end
    end


    def index
        @oficios = Oficio.all(:order => 'id DESC')

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @oficios }
        end
    end

    def oficios
        #@oficios = Oficio.find_by_sql("SELECT * FROM oficios WHERE year( data ) = "+(Time.now.year).to_s+" GROUP BY id DESC")
        @oficios = Oficio.all(:order => 'id DESC')
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @oficios }
        end
    end

    def show
        @oficio = Oficio.find(params[:id])
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @oficio }
        end
    end

    def new
        @oficio = Oficio.new
        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @oficio }
        end
    end

    def edit
        @oficio = Oficio.find(params[:id])
    end

    def create
        @oficio = Oficio.new(params[:oficio])
        respond_to do |format|
            if @oficio.save
                flash[:notice] = 'OFICIO CADASTRADO.'
                format.html { render :action => "show" }
                format.xml  { render :xml => @oficio, :status => :created, :location => @oficio }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @oficio.errors, :status => :unprocessable_entity }
            end
        end
    end

    def update
        @oficio = Oficio.find(params[:id])
        respond_to do |format|
            if @oficio.update_attributes(params[:oficio])
                flash[:notice] = 'OFICIO CADASTRADO.'
                format.html { redirect_to(@oficio) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @oficio.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        @oficio = Oficio.find(params[:id])
        @oficio.destroy
        respond_to do |format|
            format.html { redirect_to(oficios_url) }
            format.xml  { head :ok }
        end
    end
end
