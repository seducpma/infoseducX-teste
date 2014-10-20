class SeducFuncionariosController < ApplicationController
  # GET /seduc_funcionarios
  # GET /seduc_funcionarios.xml
  def index
    @seduc_funcionarios = SeducFuncionario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seduc_funcionarios }
    end
  end

  # GET /seduc_funcionarios/1
  # GET /seduc_funcionarios/1.xml
  def show
    @seduc_funcionario = SeducFuncionario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seduc_funcionario }
    end
  end

  # GET /seduc_funcionarios/new
  # GET /seduc_funcionarios/new.xml
  def new
    @seduc_funcionario = SeducFuncionario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seduc_funcionario }
    end
  end

  # GET /seduc_funcionarios/1/edit
  def edit
    @seduc_funcionario = SeducFuncionario.find(params[:id])
  end

  # POST /seduc_funcionarios
  # POST /seduc_funcionarios.xml
  def create
    @seduc_funcionario = SeducFuncionario.new(params[:seduc_funcionario])

    respond_to do |format|
      if @seduc_funcionario.save
        flash[:notice] = 'SeducFuncionario was successfully created.'
        format.html { redirect_to(@seduc_funcionario) }
        format.xml  { render :xml => @seduc_funcionario, :status => :created, :location => @seduc_funcionario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seduc_funcionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /seduc_funcionarios/1
  # PUT /seduc_funcionarios/1.xml
  def update
    @seduc_funcionario = SeducFuncionario.find(params[:id])

    respond_to do |format|
      if @seduc_funcionario.update_attributes(params[:seduc_funcionario])
        flash[:notice] = 'SeducFuncionario was successfully updated.'
        format.html { redirect_to(@seduc_funcionario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seduc_funcionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /seduc_funcionarios/1
  # DELETE /seduc_funcionarios/1.xml
  def destroy
    @seduc_funcionario = SeducFuncionario.find(params[:id])
    @seduc_funcionario.destroy

    respond_to do |format|
      format.html { redirect_to(seduc_funcionarios_url) }
      format.xml  { head :ok }
    end
  end
end
