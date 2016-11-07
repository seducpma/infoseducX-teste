class Computadore < ActiveRecord::Base
  belongs_to :unidade
  belongs_to :tipo_controle

  validates_presence_of :unidade_id, :message => ' - SELECIONAR UNIDADE  - '
validates_presence_of :tipo_controle_id, :message => ' - SELECIONAR A QUEM PERTENCE - '

def before_save
    if !self.config.nil?
      self.config.upcase!
    end
    if !self.user.nil?
       self.user.upcase!
    end
    if !self.contato.nil?
       self.contato.upcase!
    end
    if !self.pertence.nil?
       self.pertence.upcase!
    end
end



end
