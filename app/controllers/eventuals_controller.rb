class EventualsController < ApplicationController

    before_filter :load_iniciais

  def index
    @eventuals = Eventual.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @eventuals }
    end
  end

  def show
    @eventual = Eventual.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @eventual }
    end
  end

  def new
    @eventual = Eventual.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @eventual }
    end
  end

  def edit
    @eventual = Eventual.find(params[:id])
  end

  def create
    @eventual = Eventual.new(params[:eventual])
    @eventual.ano_letivo = Time.now.year
    respond_to do |format|
      if @eventual.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@eventual) }
        format.xml  { render :xml => @eventual, :status => :created, :location => @eventual }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @eventual.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @eventual = Eventual.find(params[:id])
    respond_to do |format|
      if @eventual.update_attributes(params[:eventual])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@eventual) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @eventual.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @eventual = Eventual.find(params[:id])
    @eventual.destroy
    respond_to do |format|
      format.html { redirect_to(eventuals_url) }
      format.xml  { head :ok }
    end
  end

  def consultas
      @professores_eventual= Eventual.find_by_sql("SELECT pro.id, pro.nome, eve.id FROM eventuals eve LEFT JOIN "+session[:base]+".professors pro ON eve.professor_id = pro.id WHERE eve.ano_letivo = "+(Time.now.year).to_s+" ORDER BY pro.nome")
  end


  def lista_professor
        @professors = Eventual.find(:all, :conditions => ['id= ?', params[:eventual_professor_id]])
    render :partial => 'professores'
  end

  
    def load_iniciais
         #session[:base]= 'sisgered_development'
         #session[:base]= 'sisgered_production'
            @unidades = Unidade.find(:all, :order => 'nome ASC')
            @eventuals = Eventual.find(:all,:select => "id", :conditions => ['ano_letivo=?', Time.now.year])
            @professores= Professor.find_by_sql("SELECT id, nome FROM professors WHERE `id` NOT IN ( SELECT professor_id FROM eventuals )ORDER BY nome ASC" )
    end

end
