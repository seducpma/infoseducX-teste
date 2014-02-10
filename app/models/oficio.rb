class Oficio < ActiveRecord::Base

def before_save
    self.emissor.upcase!
    self.assunto.upcase!
    self.destinatario.upcase!
    self.obs.upcase!

end

end
