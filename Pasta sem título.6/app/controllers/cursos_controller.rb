class CursosController < ApplicationController
     before_filter :load_cursos

def load_cursos
    @cursos = Curso.find(:all, :order => 'nome ASC')
    @cursosA = Curso.find(:all, :conditions => 'status = 0', :order => 'nome ASC')
    @cursosE = Curso.find(:all, :conditions => 'status = 1', :order => 'nome ASC')
  end

  def index
    @cursos = Curso.find(:all, :conditions => 'status= 0')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cursos }
    end
  end

  def show
    @curso = Curso.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cursos }
    end
  end

  def new
    @curso = Curso.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @curso }
    end
  end

  def edit
    @curso = Curso.find(params[:id])
  end

  def create
    @curso = Curso.new(params[:curso])
    @curso.nome_curto = @curso.nome
    respond_to do |format|
      if @curso.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@curso) }
        format.xml  { render :xml => @curso, :status => :created, :location => @curso }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @curso.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @curso = Curso.find(params[:id])
    respond_to do |format|
      if @curso.update_attributes(params[:curso])
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(@curso) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @curso.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @curso = Curso.find(params[:id])
    @curso.destroy
    respond_to do |format|
      format.html { redirect_to(cursos_url) }
      format.xml  { head :ok }
    end
  end

def c_curso
    render 'consultas'
  end
def consulta
    render 'consultas'
  end

def consulta_and
    render 'consultas_andamento'
end

def consulta_enc
    render 'consultas_encerrado'
end

  def lista_cursoA
    $curso = params[:curso_curso_curso_id]
    @cursos = Curso.find(:all, :conditions => ['id=? AND status = 0', params[:curso_curso_curso_id]])
    render :partial => 'lista_cursos'
  end

  def lista_cursoE
     $curso = params[:curso_curso_id]
     @cursos = Curso.find(:all, :conditions => ['id=? AND status = 1', params[:curso_curso_id]])
    render :partial => 'lista_cursos'
  end

end
