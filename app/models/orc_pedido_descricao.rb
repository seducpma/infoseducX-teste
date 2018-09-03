class OrcPedidoDescricao < ActiveRecord::Base
    belongs_to :orc_pedido_compra


  usar_como_dinheiro :unitario, :total, :total_geral


end
