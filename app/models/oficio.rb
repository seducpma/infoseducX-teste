class Oficio < ActiveRecord::Base

after_create :geracodigo

def geracodigo
    #self.codigo = [self.id-612].to_s + ("/2017")
    self.codigo = [self.id-950].to_s + ("/2018")
    self.save

end

def before_save
    self.emissor.upcase!
    self.assunto.upcase!
    self.destinatario.upcase!
    
end


end
