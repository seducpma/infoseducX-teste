class OrcEmpenhoIten < ActiveRecord::Base
  belongs_to :orc_empenho


    usar_como_dinheiro :unitario, :total, :total_geral

    before_save  :maiusculo

 def maiusculo
    if  !self.descricao.nil?
          self.descricao.upcase!
    end


  end

end
