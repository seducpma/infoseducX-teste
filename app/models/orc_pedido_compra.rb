class OrcPedidoCompra < ActiveRecord::Base
  belongs_to :orc_ficha
  has_many :orc_pedido_descricaos, :dependent => :destroy
  has_many :orc_empenhos
  #validates_presence_of :orc_ficha_id
  usar_como_dinheiro :valor_total, :valor_si, :rel_valor_si, :rel_valor_em


  after_create :geracodigo
efore_save  :maiusculo

 def maiusculo
    if  !self.objetivo.nil?
          self.objetivo.upcase!
    end
    if  !self.fornecedor.nil?
          self.fornecedor.upcase!
    end
    if  !self.justificativa.nil?
          self.justificativa.upcase!
    end
  end
def geracodigo
    #self.codigo = [self.id-612].to_s + ("/2017")
    #self.codigo = [self.id].to_s + ("/2018")
    self.ano = Time.now.year
    self.save

end
end
