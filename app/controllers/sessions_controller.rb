
class SessionsController < ApplicationController
  
  include AuthenticatedSystem
  layout "login"


 before_filter :load_cursos
  def load_cursos
    @cursos = Curso.find(:all, :conditions => ['status = 0'])
  end
  def new
  end
  
  def erro
    
  end

  
  def create

      session[:continua_atribuicao]=0
      self.current_user = User.authenticate(params[:login], params[:password])
      if logged_in?
          if params[:remember_me] == "1"
              current_user.remember_me unless current_user.remember_token?
              cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
          end
          redirect_back_or_default(home_path)
          flash[:notice]="BEM VINDO AO INFOSEDUC."
      else
          render :action => 'erro'
      end
  end
  
  def createanterior
   logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = "SISGERED ver.3.0"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end


  def destroy
    logout_killing_session!
    flash[:notice] = "VOCÊ ACABOU DE SAIR DO INFOSEDUC."
    redirect_back_or_default('/')
  end


  def aviso
      render :layout => "aviso"
  end

protected

  def note_failed_signin
    flash[:error] = "USUÁRIO NÃO AUTORIZADO '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end