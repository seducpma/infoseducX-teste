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

def  dados_prof
   @professor= Professor.find(:all, :conditions => ["id =?", params[:eventual_professor_id]])
  render :partial => 'dados_professor'
end

def  dados_unidade
   @unidade= Unidade.find(:all, :conditions => ["id =?", params[:eventual_unidade_id]])
   session[:regiao_id]= @unidade[0].regiao_id

  render :partial => 'dados_unidade'
end


  def edit
    @eventual = Eventual.find(params[:id])
  end

  def create
    @eventual = Eventual.new(params[:eventual])
    @eventual.ano_letivo = Time.now.year
    @eventual.regiao_id = session[:regiao_id]
 

    @duplicidade= Eventual.find(:all, :conditions => ['professor_id =? AND  periodo=?' , @eventual.professor_id, @eventual.periodo])
    if   @duplicidade.empty?
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
    else
         respond_to do |format|
                #flash[:notice] = 'CADASTRADO COM SUCESSO.'
                format.html { redirect_to(aviso_eventuals_path) }
                format.xml  { head :ok }
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
            #@professores= Professor.find_by_sql("SELECT id, nome FROM professors WHERE `id` NOT IN ( SELECT professor_id FROM "+session[:baseinfo]+".eventuals  )ORDER BY nome ASC" )
            @professores= Professor.find(:all, :conditions => ['desligado = 0'], :order => 'nome ASC' )
    end

 def consultaeventual
    if params[:type_of].to_i == 3
          @professors = Eventual.find(:all, :joins => "INNER JOIN "+session[:base]+".professors ON eventuals.professor_id = professors.id",:order => 'professors.nome ASC')
      render :update do |page|
         page.replace_html 'professores', :partial => "professores"
      end
    else if params[:type_of].to_i == 2
             if current_user.unidade_id == 52 or current_user.unidade_id == 53
                   @professors = Eventual.find(:all, :joins => "INNER JOIN "+session[:base]+".professors ON eventuals.professor_id = professors.id", :conditions => ["eventuals.periodo like ?", "%" + params[:search].to_s + "%"],:order => 'professors.nome ASC')
             else
                  @professors = Eventual.find(:all, :joins => "INNER JOIN "+session[:base]+".professors ON eventuals.professor_id = professors.id", :conditions => ["eventuals.periodo like ? and unidade_id=?", "%" + params[:search].to_s + "%", current_user.unidade_id],:order => 'professors.nome ASC')
             end
            render :update do |page|
               page.replace_html 'professores', :partial => "professores"
             end
       else if params[:type_of].to_i == 4
                 @professors = Eventual.find(:all, :joins => "INNER JOIN "+session[:base]+".professors ON eventuals.professor_id = professors.id", :conditions => 'eventuals.nao_atua = 0',:order => 'professors.nome ASC')
               render :update do |page|
                  page.replace_html 'professores', :partial => "professores"
               end
            else if params[:type_of].to_i == 1
                      @professors = Eventual.find(:all, :joins => "INNER JOIN "+session[:base]+".professors ON eventuals.professor_id = professors.id", :conditions => ["nome like ?", "%" + params[:search1].to_s + "%"],:order => 'professors.nome ASC')
                      render :update do |page|
                          page.replace_html 'professores', :partial => "professores"
                     end
                 else if params[:type_of].to_i == 5
                         render :update do |page|
                           page.replace_html 'professores', :partial => "professores"
                          end
                      else if params[:type_of].to_i == 6
                                 if current_user.unidade_id == 52 or current_user.unidade_id == 53
                                    @professors = Eventual.find(:all, :joins => "INNER JOIN "+session[:base]+".professors ON eventuals.professor_id = professors.id", :conditions => ["eventuals.categoria like ?", "%" + params[:searchcat].to_s + "%"],:order => 'professors.nome ASC')
                                 else
                                   @professors = Eventual.find(:all, :joins => "INNER JOIN "+session[:base]+".professors ON eventuals.professor_id = professors.id", :conditions => ["eventuals.categoria like ? and unidade_id=?", "%" + params[:search].to_s + "%", current_user.unidade_id],:order => 'professors.nome ASC')
                                 end
                               render :update do |page|
                                      page.replace_html 'professores', :partial => "professores"
                               end
                             end
                      end
                 end
            end
       end
    end
end

  def lista_professor_unidade
    #@professors = Professor.find(:all, :conditions => ['desligado =0 and unidade_id= ?', params[:unidade_id]])
    @professors = Eventual.find(:all, :joins => "INNER JOIN "+session[:base]+".professors ON eventuals.professor_id = professors.id WHERE eventuals.unidade_id = "+params[:unidade_id]+"  ",:order => 'professors.nome ASC')
    render :partial => 'professores'
  end

end
