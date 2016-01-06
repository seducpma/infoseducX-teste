class Oficio < ActiveRecord::Base

after_create :geracodigo

def geracodigo
    self.codigo = [self.id-311].to_s + ("/2016")
    self.save

end

def before_save
    self.emissor.upcase!
    self.assunto.upcase!
    self.destinatario.upcase!
    
end


end
