class OrcAtaIten < ActiveRecord::Base
  belongs_to :orc_ata

     usar_como_dinheiro :unitario, :total, :total_geral

    before_save  :maiusculo

 def maiusculo
    if  !self.descricao.nil?
          self.descricao.upcase!
    end


 end

end
