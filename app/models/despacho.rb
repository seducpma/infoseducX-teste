class Despacho < ActiveRecord::Base
  belongs_to :prefprotocolo, :dependent => :destroy

def before_save
    self.procedencia.upcase!
    self.para.upcase!
    self.despacho.upcase!
    self.destino.upcase!

end

end
