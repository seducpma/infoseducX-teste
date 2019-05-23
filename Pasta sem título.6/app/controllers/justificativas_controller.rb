class JustificativasController < ApplicationController
  def index
    @justificativas = Justificativa.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @justificativas }
    end
  end

  def show
    @justificativa = Justificativa.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @justificativa }
    end
  end

  def new
    @justificativa = Justificativa.new
    if params[:ponto_id].present?
      @ponto = Ponto.find(params[:ponto_id])
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @justificativa }
    end
  end

  def edit
    @justificativa = Justificativa.find(params[:id])
  end

  def create
    @justificativa = Justificativa.new(params[:justificativa])
    @justificativa.hora_saida
    respond_to do |format|
      if @justificativa.save
        flash[:notice] = 'JUSTIFICADO COM SUCESSO'
        format.html{ redirect_to(@justificativa) }
        format.xml  { render :xml => @justificativa, :status => :created, :location => @justificativa }
      else
        format.html { render :action => "new"}
        format.xml  { render :xml => @justificativa.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @justificativa = Justificativa.find(params[:id])
    respond_to do |format|
      if @justificativa.update_attributes(params[:justificativa])
        flash[:notice] = 'CADASTRADO COM SUCESSO.'
        format.html { redirect_to(@justificativa) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @justificativa.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @justificativa = Justificativa.find(params[:id])
    @justificativa.destroy
    respond_to do |format|
      format.html { redirect_to(justificativas_url) }
      format.xml  { head :ok }
    end
  end

  protected

  def load_ponto
    
  end
end
