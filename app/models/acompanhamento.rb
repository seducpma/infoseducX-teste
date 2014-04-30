class Acompanhamento < ActiveRecord::Base
  has_many :acompanhamento_despachos
  after_create :geracodigo


  def before_save
    self.crianca.upcase!
    self.mae.upcase!
    self.responsavel.upcase!
    self.assunto.upcase!
    self.endereco.upcase!
    self.bairro.upcase!
    self.cidade.upcase!
    
    #self.obs.upcase!
end

def geracodigo
    self.codigo = [self.id].to_s + ("/2014")
    self.save

end

end