class Oficio < ActiveRecord::Base

after_create :geracodigo

def geracodigo
    self.codigo = [self.id-11].to_s + ("/2014")
    self.save

end

end
