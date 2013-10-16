class ChefiasController < ApplicationController
  # GET /chefias
  # GET /chefias.xml

before_filter :load_users

def load_users
   @users = User.find(:all, :conditions => ["activated_at != ?", "NULL"],:order => 'login ASC')
  end


def index
   if params[:teste].to_i == 0
      if params[:search].blank?
          @search = Chefia.search(params[:search])
          @chefias = @search.all(:conditions => ['desligado = 0'],:order => 'nome ASC')
      else
          @search = Chefia.search(params[:search])
          @chefias = @search.all(:conditions => ['desligado = 0'],:order => 'nome ASC')
      end
   end
   if params[:teste].to_i == 1
      if params[:search].blank?
          @search = Chefia.search(params[:search])
          @chefias = @search.all(:conditions => ['desligado = 1'],:order => 'nome ASC')
      else
          @search = Chefia.search(params[:search])
          @chefias = @search.all(:conditions => ['desligado = 1'],:order => 'nome ASC')
      end
   end

  end


  # GET /chefias/1
  # GET /chefias/1.xml
  def show
    @chefia = Chefia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chefia }
    end
  end

  # GET /chefias/new
  # GET /chefias/new.xml
  def new
    @chefia = Chefia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chefia }
    end
  end

  # GET /chefias/1/edit
  def edit
    @chefia = Chefia.find(params[:id])
  end

  # POST /chefias
  # POST /chefias.xml
  def create
    @chefia = Chefia.new(params[:chefia])

    respond_to do |format|
      if @chefia.save
        flash[:notice] = 'Chefia was successfully created.'
        format.html { redirect_to(@chefia) }
        format.xml  { render :xml => @chefia, :status => :created, :location => @chefia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chefia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chefias/1
  # PUT /chefias/1.xml
  def update
    @chefia = Chefia.find(params[:id])

    respond_to do |format|
      if @chefia.update_attributes(params[:chefia])
        flash[:notice] = 'Chefia was successfully updated.'
        format.html { redirect_to(@chefia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chefia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chefias/1
  # DELETE /chefias/1.xml
  def destroy
    @chefia = Chefia.find(params[:id])
    @chefia.destroy

    respond_to do |format|
      format.html { redirect_to(chefias_url) }
      format.xml  { head :ok }
    end
  end
end
