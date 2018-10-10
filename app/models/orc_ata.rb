class OrcAta < ActiveRecord::Base

 belongs_to :orc_atas_iten
 has_many :orc_ata_itens, :dependent => :destroy
 has_many :orc_pedido_compra

 usar_como_dinheiro :unitario, :total, :total_geral, :valor_total

before_save  :maiusculo

 def maiusculo
    if  !self.objetivo.nil?
          self.objetivo.upcase!
    end
    if  !self.interessado.nil?
          self.interessado.upcase!
    end
    if  !self.endereco.nil?
          self.endereco.upcase!
    end
    if  !self.cidade.nil?
          self.cidade.upcase!
    end
    if  !self.estado.nil?
          self.estado.upcase!
    end
    if  !self.contato.nil?
          self.contato.upcase!
    end
    if  !self.obs.nil?
          self.obs.upcase!
    end

 end







end
