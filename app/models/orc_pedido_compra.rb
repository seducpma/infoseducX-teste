class OrcPedidoCompra < ActiveRecord::Base
  belongs_to :orc_ficha
  has_many :orc_pedido_descricaos, :dependent => :destroy
  has_many :orc_empenhos
  #validates_presence_of :orc_ficha_id
  usar_como_dinheiro :valor_total


  after_create :geracodigo

def geracodigo
    #self.codigo = [self.id-612].to_s + ("/2017")
    #self.codigo = [self.id].to_s + ("/2018")
    self.ano = Time.now.year
    self.save

end
end
