class OrcEmpenho < ActiveRecord::Base
  belongs_to :orc_pedido_compra
  #has_many :cart_items
  #has_many :dpus, :through => :cart_items

 has_many :orc_empenho_itens, :dependent => :destroy
   #validates_presence_of :orc_pedido_compra_id
   usar_como_dinheiro :valor_total, :rel_valor_em
   before_save  :salva_dados
   #after_save  :atualiza_saldo



    def salva_dados
        teste=self.orc_pedido_compra_id
      if !teste.nil?
          @orc_pedido_compra = OrcPedidoCompra.find(:all, :conditions => ["id =?" , self.orc_pedido_compra_id])
            self.interessado =@orc_pedido_compra[0].fornecedor
            self.ficha = @orc_pedido_compra[0].orc_ficha.ficha
            self.despesa = @orc_pedido_compra[0].orc_ficha.orc_uni_orcamentaria.orc_uni_despesa.descricao
            self.projeto = @orc_pedido_compra[0].orc_ficha.orc_uni_orcamentaria.descricao
            self.destinacao = @orc_pedido_compra[0].orc_ficha.orc_uni_orcamentaria.orc_uni_despesa.descricao
               
      end
    end

    #def atualiza_saldo
    #  teste = self.orc_pedido_compra_id
    #  if !teste.nil?
    #    @ficha = OrcFicha.find(:all, :conditions => ['id =?', self.orc_pedido_compra.orc_ficha.id])
    #    @ficha[0].saldo_empenhado = @ficha[0].saldo_empenhado - self.valor_total
    #    @ficha[0].save
    #  end
    #end
end