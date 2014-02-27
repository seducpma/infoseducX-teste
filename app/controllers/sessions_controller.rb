# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

 before_filter :load_cursos
  def load_cursos
    @cursos = Curso.find(:all, :order => 'nome ASC', :conditions => ['status = 0'])
  end

  layout "login"
  # render new.erb.html
  def new
  end

 def informatica
    render 'informatica'
 end


 def manutencao
    render 'manutencao'
 end

 def oficio
    render 'oficio'
 end

def interno
    render 'interno'
 end

def protocolo
    render 'protocolo'
 end

  def create
   logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      if current_user.has_role?('oficios')
        redirect_to oficios_path
        #redirect_to livros_cadastrados_livros_path
        flash[:notice] = "BEM VINDO AO INFOSEDUC ver.5.3"
      else
      redirect_back_or_default('/')
      flash[:notice] = "BEM VINDO AO INFOSEDUC ver.5.3"

      end
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end


  def destroy
    logout_killing_session!
    flash[:notice] = "VOCÊ ACABOU DE SAIR DO INFOSEDUC"
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "USUÁRIO NÂO PODER SER LOGADO AO INFOSEDUC '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
