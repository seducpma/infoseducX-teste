class TiposManutencaosController < ApplicationController
  # GET /tipos_manutencaos
  # GET /tipos_manutencaos.xml
  def new
    @tipos_manutencao = TiposManutencao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipos_manutencao }
    end
  end

  def create
    @tipos_manutencao = TiposManutencao.new(params[:tipos_manutencao])

    respond_to do |format|
      if @tipos_manutencao.save
        flash[:notice] = 'SALVO COM SUCESSO.'
        format.html { redirect_to(new_tipos_manutencao_path) }
        format.xml  { render :xml => @tipos_manutencao, :status => :created, :location => @tipos_manutencao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipos_manutencao.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /tipos_manutencaos/1
  # DELETE /tipos_manutencaos/1.xml
  def destroy
    @tipos_manutencao = TiposManutencao.find(params[:id])
    @tipos_manutencao.destroy

    respond_to do |format|
      format.html { redirect_to(new_tipos_manutencao_path) }
      format.xml  { head :ok }
    end
  end

  def lista
    @tipos_manutencao = TiposManutencao.find(:all)
    render :partial => 'lista_servicos'

  end

end
