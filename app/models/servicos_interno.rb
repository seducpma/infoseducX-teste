class ServicosInterno < ActiveRecord::Base

  after_create :geracodigo

def geracodigo
    self.codigo = [self.id+19].to_s + ("/2014")
    self.save

end





end
