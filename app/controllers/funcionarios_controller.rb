class FuncionariosController < ApplicationController
  # GET /funcionarios
  # GET /funcionarios.xml
  before_filter :load_chefias

  def load_chefias
    @chefias = Chefia.find(:all,:order => 'nome ASC',:conditions => ['desligado=?',0])

  end



def index
  if params[:teste].to_i == 0
      if params[:search].blank?
          @search = Funcionario.search(params[:search])
          @funcionarios = @search.all(:conditions => ['desligado = 0'],:order => 'nome ASC')
      else
          @search = Funcionario.search(params[:search])
          @funcionarios = @search.all(:conditions => ['desligado = 0'],:order => 'nome ASC')
      end
  end
  if params[:teste].to_i == 1
      if params[:search].blank?
          @search = Funcionario.search(params[:search])
          @funcionarios = @search.all(:conditions => ['desligado = 1'],:order => 'nome ASC')
      else
          @search = Funcionario.search(params[:search])
          @funcionarios = @search.all(:conditions => ['desligado = 1'],:order => 'nome ASC')
      end
  end

  end
  




  # GET /funcionarios/1
  # GET /funcionarios/1.xml
  def show
    @funcionario = Funcionario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @funcionario }
    end
  end

  # GET /funcionarios/new
  # GET /funcionarios/new.xml
  def new
    @funcionario = Funcionario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @funcionario }
    end
  end

  # GET /funcionarios/1/edit
  def edit
    @funcionario = Funcionario.find(params[:id])
  end

  # POST /funcionarios
  # POST /funcionarios.xml
  def create
    @funcionario = Funcionario.new(params[:funcionario])

    respond_to do |format|
      if @funcionario.save
        flash[:notice] = 'Funcionario was successfully created.'
        format.html { redirect_to(@funcionario) }
        format.xml  { render :xml => @funcionario, :status => :created, :location => @funcionario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @funcionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /funcionarios/1
  # PUT /funcionarios/1.xml
  def update
    @funcionario = Funcionario.find(params[:id])

    respond_to do |format|
      if @funcionario.update_attributes(params[:funcionario])
        flash[:notice] = 'Funcionario was successfully updated.'
        format.html { redirect_to(@funcionario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @funcionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /funcionarios/1
  # DELETE /funcionarios/1.xml
  def destroy
    @funcionario = Funcionario.find(params[:id])
    @funcionario.destroy

    respond_to do |format|
      format.html { redirect_to(funcionarios_url) }
      format.xml  { head :ok }
    end
  end
end
