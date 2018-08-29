class OrcFicha < ActiveRecord::Base

  belongs_to :orc_uni_orcamentaria
  has_many :orc_pedido_compra
  has_many :orc_suplementacao
  has_many :orc_pagamento

 usar_como_dinheiro :saldo_atual, :valor_inicial, :saldo, :saldo_empenhado, :saldo_reservado, :saldo_transferido, :saldo_aporte

  def before_save
    if  !self.descricao.nil?
       self.descricao.upcase!
    end
  end
 
end
