class Participante < ActiveRecord::Base

  has_many :inscricaos
  belongs_to :unidade
  belongs_to :curso
  validates_presence_of :nome, :message => ' - PREENCHIMENTO OBRIGATÓRIO'
  validates_presence_of :email, :message => ' - FAVOR CASDASTRAR E_MAIL'
  validates_presence_of :rg, :message => ' - PREENCHIMENTO OBRIGATÓRIO'
  validates_presence_of :funcao, :message => ' - PREENCHIMENTO OBRIGATÓRIO'
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  #validates_uniqueness_of   :email
  # validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  #validates :email, :if => :verifica_email?, :message => "Email precisa ser confirmado"
  attr_accessor :email_confirmation

  
def before_save
    self.nome.upcase!
    
#    self.obs.upcase!
end

def existe_email
  if self.email.present?
    self.email
  else
    ""
  end
end

def verifica_email?
  e = self.email
  ec = self.email_confirmation
end
def possuidadosobrigatorios?
  if email
    true
  else
    false
  end
end

protected

def tipo?
  if self.tipo_participante == 1
    true
  else
    if self.tipo_participante == 2
      false
    end
  end
end


end
