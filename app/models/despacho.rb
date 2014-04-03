class Despacho < ActiveRecord::Base
  belongs_to :prefprotocolo, :dependent => :destroy
  before_save :acerto


  def acerto

     #@saldo = Estoque.find(self.estoque_id)
     @anterior = Prefprotocolo.find(self.prefprotocolo_id)
     $anterior=@anterior.destino
     $atual = self.destino

      if ($anterior != $atual)
        @anterior.destino = $atual
        @anterior.save
     end

     #@saldo.saldo = @saldo.saldo - self.quantidade

     #@saldo.save

  end



end
