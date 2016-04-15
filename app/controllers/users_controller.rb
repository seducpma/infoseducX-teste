class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  layout "user"

  before_filter :load_users

  def load_users
    @users =User.find(:all, :order => 'login ASC')
  end

  # render new.rhtml
  def new
    @user = User.new
  end


  def criado

  end


  def create
      logout_keeping_session!
    @user = User.new(params[:user])
    
    success = @user && @user.save
    if success && @user.errors.empty?
     # redirect_back_or_default('/')
      render :action => 'criado'
      flash[:notice] = "USUÁRIO CRIADO COM SUCESSO, ENTRE EM CONTATO COM O ADMINISTRADOR DO SISTEMA PARA LIBERAÇÃO."
      t=0
    else
      flash[:error]  = "SENHA OU USUÁRIO NÃO AUTORIZADO "
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'CADASTRADO COM SUCESSO.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def show
    @users = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def index
    if (params[:search].nil? || params[:search].empty?)
      @users = User.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 6

    else
      @users = User.find(:all, :conditions => ["login like ?", "%" + params[:search].to_s + "%"], :order => 'login ASC')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

def destroy
    @users = User.find(params[:id])
    @users.destroy

    respond_to do |format|
      format.html { redirect_to(homes_path) }
      format.xml  { head :ok }
    end
  end

 def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "ACESSO EFETUADA COM SUCESSO"
    end
    redirect_back_or_default('/')
  end
  
end
