class OrcPagamento < ActiveRecord::Base
  belongs_to :orc_empenho
  belongs_to :orc_ficha

  usar_como_dinheiro :valor_pg, :rel_valor_op, :rel_valor_em

end
