class Oficio < ActiveRecord::Base

after_create :geracodigo

def geracodigo
    self.codigo = [self.id-167].to_s + ("/2015")
    self.save

end

def before_save
    self.emissor.upcase!
    self.assunto.upcase!
    self.destinatario.upcase!
    
end


end
