class OrcPagamento < ActiveRecord::Base
  belongs_to :orc_empenho
  belongs_to :orc_ficha

  usar_como_dinheiro :valor_pg

end
