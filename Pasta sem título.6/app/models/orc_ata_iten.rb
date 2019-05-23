class OrcAtaIten < ActiveRecord::Base
  belongs_to :orc_ata

     usar_como_dinheiro :unitario, :total, :total_geral, :valor_total

    before_save  :maiusculo

 def maiusculo
    if  !self.descricao.nil?
          self.descricao.upcase!
    end
    if  !self.medida.nil?
          self.medida.upcase!
    end



 end

end
