class OrcNotaFiscal < ActiveRecord::Base
  belongs_to :orc_empenho
  has_many :orc_nota_fiscal_itens, :dependent => :destroy

    usar_como_dinheiro :valor

end
